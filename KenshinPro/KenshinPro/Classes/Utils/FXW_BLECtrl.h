//
//  FXW_BLECtrl.h
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 记得在info.plist中设置蓝牙权限
 
 低功耗蓝牙 BLE4.0的封装 单例类
 
 功能概述：手机蓝牙状态、扫描设备、连接设备、读写数据等 所有回调通过block实现
 
 
 */
@interface FXW_BLECtrl : NSObject


/**
 手机蓝牙是否打开
 */
@property (nonatomic, assign) BOOL                          isOpenBle;

/**
 手机蓝牙是否开启的block
 
 @param isOpenBle YES 手机蓝牙已开启 NO 手机蓝牙已关闭
 */
typedef void (^BleStateBlock)(BOOL isOpenBle);

/**
 监听手机蓝牙状态的回调 当手机蓝牙状态发生改变时触发
 
 @param block BleStateBlock
 */
- (void) bleStateWithResultBlock:(BleStateBlock)block;

/**
 如果手机蓝牙未打开，就显示系统弹窗，提示用户设置手机蓝牙
 */
- (void)ifShowSystemAlertTipsUserSettingBluetooth;





@end
