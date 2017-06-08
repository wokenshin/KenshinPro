//
//  BLECoreVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/7.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BLECoreVC.h"
#import <CoreBluetooth/CoreBluetooth.h>


/**
 推荐学习
 
 BLE 入门      http://www.jianshu.com/p/c9b20fe17600  【已看 好文】
 BLE 第一章    http://www.jianshu.com/p/760f042a1d81  【已看 好文】
 BLE 其他章节  http://www.jianshu.com/u/3f8e2a3945de  【已看 好文】2 ~6章
 */
@interface BLECoreVC ()<CBCentralManagerDelegate>

//BLE 中心设备
@property (nonatomic, strong) CBCentralManager              *bleCentral;

@end

@implementation BLECoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBLECoreVCUI];
    [self initSomething];
    
}

- (void)initBLECoreVCUI
{
    self.navigationItem.title = @"BLE核心";
    
}

- (void)initSomething
{
    /*
     初始化中心
     self被设置为delegate，以接收任何central角色的事件
     如果指定dispatch queue为nil，central manager将在主线程中分发事件
     */
    
    //step:1
    _bleCentral = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    
    /*
     当你创建一个central manager，它会调用它的delegate对象的centralManagerDidUpdateState:
     方法。你必须实现这个delegate方法以保证central设备支持BLE并可以正常使用。
     */
    
}

//step:2
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    /*[这里只是翻译了方法的注释]
     当中央经理的状态更新时调用。
     您可以实施此所需的方法，以确保支持蓝牙低能耗并可在中央设备上使用。 只有当中央管理员的状态打开时，才能向中央管理员发出命令，如CBCentralManagerStatePoweredOn常数所示。 值低于CBCentralManagerStatePoweredOn的状态意味着扫描已停止，任何连接的外围设备已断开连接。 如果状态移动到CBCentralManagerStatePoweredOff之下，则从该中央管理器获取的所有CBPeripheral对象将变为无效，并且必须重新检索或再次发现。 有关代表中央管理员状态的可能值的完整列表和讨论，请参阅CBCentralManager中的CBCentralManagerState枚举。
     */
    
    
    
}











































- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
