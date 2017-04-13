//
//  BLEVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BLEVC.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEVC ()<CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager                  *bleCenter;

/**
 用于存储扫描到的设备
 */
@property (nonatomic, strong)NSMutableArray                     *devicesListArray;

@end

@implementation BLEVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"暂时没实现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化中央设备
    _bleCenter = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    //-->centralManagerDidUpdateState:
    
}



#pragma mark - 扫描蓝牙设备
- (IBAction)clickScanBleDevice:(id)sender
{
    //这里我们参数都传的是nil, 意思就是扫描所有的外设.当然你也可以传一个UUID进去, 是以数组的形式传得.这里由于我们做的是模拟第一次连接, 也就没有指定的UUID了, 有兴趣的可以自己测一下传一个UUID进去.
    [_bleCenter scanForPeripheralsWithServices:nil options:nil];
    //-->centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
    
}

#pragma mark - 停止扫描
- (IBAction)clickStopScan:(id)sender
{
    [_bleCenter stopScan];
    
}



#pragma mark CBCentralManager 代理
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            NSLog(@"蓝牙不可用");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"未授权");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"蓝牙未打开");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已打开");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"状态未知");
        default:
            NSLog(@"不明情况了");
    }
    
}

/*...扫描到外设的时候会调该方法...*/
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if(![self.devicesListArray containsObject:peripheral])
    {
        [self.devicesListArray addObject:peripheral];
    }
    
//    NSLog(@"UUID %@", peripheral.identifier);//peripheral.identifier就是外设的UUID
//    NSLog(@"广告 %@", advertisementData);//广告数据
//    NSLog(@"信号强度 %@", RSSI);
//    NSLog(@"%@", peripheral);
    
    NSString *state = @"未获取到连接状态";
    
    //获取设备的状态
    switch (peripheral.state)
    {
        case CBPeripheralStateDisconnected:
            state = @"断开连接";
            break;
        case CBPeripheralStateConnecting:
            state = @"正在连接";
            break;
        case CBPeripheralStateConnected:
            state = @"已连接";
            break;
        case CBPeripheralStateDisconnecting:
            state = @"正在断开";
            break;
        default:
            break;
    }
    
    NSLog(@"--------------------------------\n RSSI %@ \n UUID %@ \n name %@ \n state %@ \n 广告 %@", RSSI, peripheral.identifier, peripheral.name, state, advertisementData);
    
}

#pragma mark - 连接设备
- (IBAction)clickConnectDevice:(id)sender
{
    

}

#pragma mark - 发现服务中的特征值
- (IBAction)clickFindServiceCharac:(id)sender
{
    
    
}


#pragma mark - 获取特征值
- (IBAction)clickGetCharac:(id)sender
{
    
    
}


#pragma mark - 订阅特征值
- (IBAction)clickDingYueCharac:(id)sender
{
    
    
}


#pragma mark - 写入特征值
- (IBAction)clickWriteCharac:(id)sender
{
    
    
}


@end
