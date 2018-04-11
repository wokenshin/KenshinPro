//
//  JJSJVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/18.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JJSJVC.h"
#import "JJSJRecodeVoiceVC.h"
#import "GYZJVC.h"
#import "IMBaseVC.h"

@interface JJSJVC ()
@property (nonatomic, strong) UIImageView           *imgView1;
@property (nonatomic, strong) UIImageView           *imgView2;
@property (nonatomic, strong) UIImageView           *imgView3;

@property (weak, nonatomic) IBOutlet UIImageView    *imgAnima;


@end

@implementation JJSJVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JJSJ";
    [self wechatVoiceUI];
    [self animationUI];
    
}

#pragma mark 获取图片
- (IBAction)clickBtnGetPic:(id)sender
{
    GYZJVC *vc = [[GYZJVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 录音工具 格式转换
- (IBAction)clickBtnRecodeVoiceToolsShow:(id)sender
{
    JJSJRecodeVoiceVC *vc = [[JJSJRecodeVoiceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 开始动画
- (IBAction)clickBtnStartAnimatioon:(id)sender
{
    if (_imgAnima.isAnimating) {
        NSLog(@"动画中...");
        return;
    }
    [_imgAnima startAnimating];
}

#pragma mark 结束动画
- (IBAction)clickBtnStopAnimatioon:(id)sender
{
    if (_imgAnima.isAnimating) {
        [_imgAnima stopAnimating];
        return;
    }
    NSLog(@"都没动画 结束个毛线");
}


#pragma mark 延展UI
- (void)wechatVoiceUI
{
    CGFloat margin  = 350;
    CGFloat marginL = 20;
    CGFloat imgH    = 40;
    
    _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(marginL, margin, screenWidth*0.7, imgH)];
    _imgView1.image = [[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
    [self.view addSubview:_imgView1];
    
    _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(marginL, margin + imgH + 10, screenWidth*0.5, imgH)];
    _imgView2.image = [[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
    [self.view addSubview:_imgView2];
    
    _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(marginL, margin + imgH*2 + 10*2, screenWidth*0.3, imgH*2)];
    _imgView3.image = [[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
    [self.view addSubview:_imgView3];
    
}

- (void)animationUI
{
    //xib
    _imgAnima.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"wechatvoice4_0"],
                                [UIImage imageNamed:@"wechatvoice4_1"],
                                [UIImage imageNamed:@"wechatvoice4"],nil];
    
    _imgAnima.animationDuration    = 1.0;//每一张图片切换的时间
    _imgAnima.animationRepeatCount = 0;//循环次数
}

- (IBAction)clickBtnIMUI:(id)sender
{
    IMBaseVC *vc = [[IMBaseVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickBtnMore:(id)sender
{
    [self toastBottom:@"暂无"];
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
