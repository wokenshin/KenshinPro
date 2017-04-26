//
//  ScanErWeiMaOneVC.m
//  GYBase
//
//  Created by kenshin on 16/8/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ScanErWeiMaOneVC.h"
#import <AVFoundation/AVFoundation.h>

//来自美团仿:[虽然是显示中间在扫描 但是整个屏幕都在扫描]
@interface ScanErWeiMaOneVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureSession           *session;


@end

@implementation ScanErWeiMaOneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpUI];
    [self beginReadQRCoder];
    [self scanLineAnimation];
    
}

- (void)setUpUI
{
    // 设置扫描框
    UIView *scanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    scanView.center = self.view.center;
    scanView.backgroundColor = [UIColor clearColor];
    scanView.layer.borderWidth = 1;
    scanView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:scanView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25, 50, 50)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"icon_pathMenu_background"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    backBtn.layer.cornerRadius = 25;
    backBtn.clipsToBounds = YES;
    backBtn.backgroundColor = [UIColor blackColor];
    backBtn.alpha = 0.5;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 扫描框动画
 */
- (void)scanLineAnimation
{
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.bounds = CGRectMake(0, 0, 198, 2);
    lineLayer.position = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    lineLayer.backgroundColor = [UIColor whiteColor].CGColor;
    lineLayer.borderColor = [UIColor whiteColor].CGColor;
    
    lineLayer.shadowColor = [UIColor yellowColor].CGColor;
    lineLayer.shadowOffset = CGSizeMake(2, 1);
    lineLayer.shadowOpacity = 1;
    lineLayer.shadowRadius = 5;
    [self.view.layer addSublayer:lineLayer];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat x = self.view.frame.size.width/2;
    CGFloat y = self.view.frame.size.height / 2;
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(x, y - 100)];
    NSValue *pathValue = [NSValue valueWithCGPoint:CGPointMake(x, y + 100)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(x, y - 100)];
    keyAnimation.values = @[fromValue,pathValue,toValue];
    keyAnimation.duration = 5;
    keyAnimation.repeatCount = HUGE_VALF;
    [lineLayer addAnimation:keyAnimation forKey:@"lineLayerAnimation"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)beginReadQRCoder
{
    // 1.摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.设置输入
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        
        NSLog(@"没有摄像头");
        return;
    }
    
    // 3.设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    // 3.1 设置输出的代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4.拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    
    // 添加session的输入和输出
    [session addInput:input];
    [session addOutput:output];
    
    // 4.1 设置输出的格式
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 5.设置预览图层 (用来让用户能够看到扫描情况)
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    // 5.1设置图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    // 5.1设置preview图层的大小
    
    [preview setFrame:self.view.bounds];
    
    // 5.2将图层添加的视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    
    self.previewLayer = preview;
    
    // 6.启动会话
    [session startRunning];
    
    self.session = session;
}

#pragma mark - 输出代理方法

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 会频繁的扫描，调用代理方法
    // 1.如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2.删除图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3.设置界面显示扫描结果
    NSLog(@"%@,",metadataObjects);
    
    if (metadataObjects.count >0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString *scanResult = obj.stringValue;
        if ([scanResult containsString:@"http"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scanResult]];
        }
        else
        {
            [Tools toast:@"暂不支持条形码扫描" andCuView:self.view];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
