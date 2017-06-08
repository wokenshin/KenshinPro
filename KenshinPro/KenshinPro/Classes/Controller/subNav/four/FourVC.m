//
//  FourVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FourVC.h"
#import "DesignModeVC.h"
#import "BLECoreVC.h"





@interface FourVC ()

@end

@implementation FourVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initFourVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"设计模式" andDetail:@"常用的设计模式"];
    [self addDataWithTitle:@"BLE核心" andDetail:@"由浅入深"];
    
}

- (void)initFourVCUI
{
    self.navigationItem.title = @"高级";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"设计模式"])
    {
        DesignModeVC *vc = [[DesignModeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"BLE核心"])
    {
        BLECoreVC *vc = [[BLECoreVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toastBottom:@"没有实现该功能"];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
