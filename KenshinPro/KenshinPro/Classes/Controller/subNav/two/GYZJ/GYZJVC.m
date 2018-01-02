//
//  GYZJVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/27.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GYZJVC.h"

@interface GYZJVC ()

//用来显示获取到的图片
@property (weak, nonatomic) IBOutlet UIImageView         *imgView;
@property (nonatomic, strong)        UIAlertController   *alertController;
@end

@implementation GYZJVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"GYZJ_IM";
    
}


#pragma mark 上传头像
//1.选择相册图片 or 拍照
//2.上传图片 bye AFN
- (IBAction)uploadPic:(id)sender
{
    WS(ws);
    if (_alertController == nil)
    {
        _alertController = [UIAlertController alertControllerWithTitle:@"设置头像"
                                                               message:nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照选择"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action){
                                                              [ws takePhoto];
                                                          }];
        
        UIAlertAction *localPhoto = [UIAlertAction actionWithTitle:@"本地图片"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               [ws localPhoto];
                                                           }];
        
        UIAlertAction *clearPhoto = [UIAlertAction actionWithTitle:@"清空头像"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               [ws clearPhoto];
                                                           }];
        
        UIAlertAction *cancelPhoto = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
        
        //按钮的顺序由UIAlertAction 的style来决定的
        [_alertController addAction:takePhoto];
        [_alertController addAction:localPhoto];
        [_alertController addAction:clearPhoto];
        [_alertController addAction:cancelPhoto];
    }
    
    //显示alertController
    [self presentViewController:_alertController animated:YES completion:nil];
    
}

#pragma mark 相册
- (void)localPhoto
{
    //接口可以根据自己的需要来扩展:例如 不需要将图片保存到本地、指定文件名称等
    WS(ws);
    [self fxw_photoLocalWithResultBlock:^(NSData *imgData, NSString *imgPath) {
        UIImage  *img = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:imgPath,NSHomeDirectory()]];
        img = nil;
        ws.imgView.image = [UIImage imageWithData:imgData];
        
    }];
}

#pragma mark 拍照
- (void)takePhoto
{
    WS(ws);
    [self fxw_photoTakeWithResultBlock:^(NSData *imgData, NSString *imgPath) {
        UIImage  *img = [[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:imgPath,NSHomeDirectory()]];
        img = nil;
        ws.imgView.image = [UIImage imageWithData:imgData];

    }];
}

- (void)clearPhoto
{
    _imgView.image = [UIImage imageNamed:@"biaoqing"];
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
