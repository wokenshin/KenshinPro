//
//  FXW_BLECtrl.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_BLECtrl.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface FXW_BLECtrl()<CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager              *centralManager;

@property (nonatomic, copy) BleStateBlock                   bleStateCallback;


@end

@implementation FXW_BLECtrl


- (instancetype) init
{
    self = [super init];
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    return self;
    
}

#pragma mark - 蓝牙底层回调

#pragma mark -- 蓝牙状态更新回调
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBManagerStatePoweredOn:
        {
            _isOpenBle = YES;
            if (_bleStateCallback)
            {
                _bleStateCallback(_isOpenBle);
            }
        }
            break;
        case CBManagerStatePoweredOff:
        {
            _isOpenBle = NO;
            if (_bleStateCallback)
            {
                _bleStateCallback(_isOpenBle);
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)ifShowSystemAlertTipsUserSettingBluetooth;
{
    CBCentralManager *tmpObj = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    tmpObj = nil;
    //此时如果蓝牙没有开启的话，会弹出系统提示框 提示用户开启蓝牙
    //触发下面的代理 只会调用一次 centralManagerDidUpdateState:
    
}

//当手机蓝牙状态发生改变时会触发
- (void)bleStateWithResultBlock:(BleStateBlock)block
{
    _bleStateCallback = block;
    
}
@end
