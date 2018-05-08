//
//  FiveVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FiveVC.h"
#import "FYScrollViewVC.h"
#import "FYMenuVC.h"
#import "FYMenu2VC.h"
#import "JJSJHomeVC.h"
#import "PuerTCellVC.h"
#import "PureCodeViewVC.h"
#import "ShowDateVC.h"

@interface FiveVC ()

@end

@implementation FiveVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFiveVCUI];
    [self loadData];
    
}

- (void)initFiveVCUI
{
    self.navigationItem.title = @"UI模块-快速开发";
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    [self addDataWithTitle:@"广告视图" andDetail:@"第三方"];
    [self addDataWithTitle:@"菜单-垂直方向" andDetail:@""];
    [self addDataWithTitle:@"菜单-水平方向" andDetail:@""];
    [self addDataWithTitle:@"应用-JJSJ首页" andDetail:@""];
    [self addDataWithTitle:@"纯代码TableCell" andDetail:@"JJSJUISDK"];
    [self addDataWithTitle:@"纯代码View" andDetail:@"JJSJUISDK"];
    [self addDataWithTitle:@"显示时间" andDetail:@"JJSJUISDK"];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"显示时间"])
    {
        [self fxw_pushVC:[[ShowDateVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"纯代码View"])
    {
        [self fxw_pushVC:[[PureCodeViewVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"纯代码TableCell"])
    {
        [self fxw_pushVC:[[PuerTCellVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"应用-JJSJ首页"])
    {
        [self fxw_pushVC:[[JJSJHomeVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"菜单-水平方向"])
    {
        [self fxw_pushVC:[[FYMenu2VC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"菜单-垂直方向"])
    {
        [self fxw_pushVC:[[FYMenuVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"广告视图"])
    {
        [self fxw_pushVC:[[FYScrollViewVC alloc] init]];
        return;
    }

    [self toastBottom:@"没有实现该功能"];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}
@end
