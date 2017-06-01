//
//  FXW_BLECtrlDemoVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_BLECtrlDemoVC.h"
#import "FXW_BLECtrl.h"

@interface FXW_BLECtrlDemoVC ()

@property (nonatomic, strong) FXW_BLECtrl               *shareBle;

@end

@implementation FXW_BLECtrlDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //主要用来演示 后期封装的低功耗蓝牙库
    
    _shareBle = [[FXW_BLECtrl alloc] init];
    
    //用单例的时候发现一个问题，就是vc释放之后 这里的block还是会被调用
    [_shareBle bleStateWithResultBlock:^(BOOL isOpenBle) {
        if (isOpenBle)
        {
            NSLog(@"蓝牙已打开");
        }
        else
        {
            NSLog(@"蓝牙已关闭");
        }
    }];
    
    [_shareBle ifShowSystemAlertTipsUserSettingBluetooth];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
