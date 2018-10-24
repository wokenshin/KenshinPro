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
#import "FXWWebVC.h"
#import "RSAVC.h"


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
    [self addDataWithTitle:@"网页控制器-远端" andDetail:@"2018.8.8"];
    [self addDataWithTitle:@"网页控制器-本地" andDetail:@"2018.8.9"];
    [self addDataWithTitle:@"RSA 加解密 base64" andDetail:@"2018.9.7"];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    //[self addDataWithTitle:@"" andDetail:@""];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@""]) {
        
        return;
    }
    if ([title isEqualToString:@"RSA 加解密 base64"]) {
        RSAVC *vc = [[RSAVC alloc] init];
        [self fxw_pushVC:vc];
        return;
    }
    if ([title isEqualToString:@"网页控制器-本地"])
    {
        //加载本地html
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userHelp" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        FXWWebVC *webVC = [[FXWWebVC alloc] init];
        [webVC loadLocalContent:htmlString];
        [self fxw_pushVC:webVC];
        return;
    }
    if ([title isEqualToString:@"网页控制器-远端"])
    {
        //加载远端web
        FXWWebVC *webVC = [[FXWWebVC alloc] init];
        [webVC loadUrl:@"http://39.104.230.77:8888/map/view"];
        [self fxw_pushVC:webVC];
        return;
    }
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
