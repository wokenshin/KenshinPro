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
#import "ListCodesVC.h"
#import "RespondCodesVC.h"
#import "RunLoopFXWVC.h"
#import "DebugLogVC.h"
#import "RuntimeVC.h"
#import "CJJMVC.h"
#import <JJSJIM/JJSJIM.h>
#import "JavaLearnVC.h"

@interface FourVC ()

@end

@implementation FourVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFourVCUI];
    [self loadData];
    
}

- (void)initFourVCUI
{
    self.navigationItem.title = @"高级";
    [self.view addSubview:self.tableView];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"设计模式"  andDetail:@"常用的设计模式"];
    [self addDataWithTitle:@"BLE核心"  andDetail:@"由浅入深"];
    [self addDataWithTitle:@"链式编程"  andDetail:@"小demo"];
    [self addDataWithTitle:@"响应式编程" andDetail:@"待更新..."];
    [self addDataWithTitle:@"DebugView" andDetail:@"2017-10-20"];
    [self addDataWithTitle:@"RunLoop"  andDetail:@"2017-10-18"];
    [self addDataWithTitle:@"runtime"  andDetail:@"2017-11-08"];
    [self addDataWithTitle:@"C语言实现加解密-生成库文件"  andDetail:@"让安卓iOS都可以调用"];
    [self addDataWithTitle:@"mySDK test"  andDetail:@"2018-2-27"];
    [self addDataWithTitle:@"Java后端学习"  andDetail:@"2018-5-14"];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"Java后端学习"])
    {
        [self fxw_pushVC:[[JavaLearnVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"mySDK test"])
    {
        [self test];
        return;
    }
    if ([title isEqualToString:@"C语言实现加解密-生成库文件"])
    {
        [self fxw_pushVC:[[CJJMVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"runtime"])
    {
        [self fxw_pushVC:[[RuntimeVC alloc] init]];
        return;
    }
    if ([title isEqualToString:@"DebugView"])
    {
        DebugLogVC *vc = [[DebugLogVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"RunLoop"])
    {
        RunLoopFXWVC *vc = [[RunLoopFXWVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
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
    if ([title isEqualToString:@"链式编程"])
    {
        ListCodesVC *vc = [[ListCodesVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"响应式编程"])
    {
        RespondCodesVC *vc = [[RespondCodesVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toastBottom:@"没有实现该功能"];
    
}

- (void)test
{
    [Test print:@"难道这就搞定了？"];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}

@end
