//
//  CommonUIVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CommonUIVC.h"

@interface CommonUIVC ()

@end

@implementation CommonUIVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initMenusVCUI];
    
}

- (void)loadData
{
    
    [self addDataWithTitle:@"FXW_Button" andDetail:@"block回调实现事件监听"];
    [self addDataWithTitle:@"FXW_Control" andDetail:@"block回调实现事件监听"];
    [self addDataWithTitle:@"FXW_TextField" andDetail:@"对文本的监听，长度的限制"];
    [self addDataWithTitle:@"FXW_TextView" andDetail:@"对文本的监听，长度的限制"];
    [self addDataWithTitle:@"PopSelect" andDetail:@"弹框选择 是一个table"];
    
}

- (void)initMenusVCUI
{
    self.navigationItem.title = @"各种菜单";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"系统通讯录"])
    {
        
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
