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


@end

@implementation BLECoreVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBLECoreVCUI];
    
    
}

- (void)initBLECoreVCUI
{
    self.navigationItem.title = @"BLE核心";
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
