//
//  SmartDeviceContentVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/9/26.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SmartDeviceContentVC.h"
#import "SmartWebVC.h"
@interface SmartDeviceContentVC ()

@end

@implementation SmartDeviceContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"蓝牙工具App";
    
}

#pragma mark 网页下载资源
- (IBAction)clickWebDownloadSources:(id)sender
{
    SmartWebVC *vc = [[SmartWebVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
