//
//  GetContactsVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GetContactsVC.h"
#import "CustomContactsVC.h"
#import "SysContactsVC.h"

@interface GetContactsVC ()

@end

@implementation GetContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initContactsUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"系统通讯录" andDetail:@"推荐使用 兼容7到10"];
    [self addDataWithTitle:@"自定义通讯录" andDetail:@"只是获取了通讯录里面的数据"];
    
}

- (void)initContactsUI
{
    self.navigationItem.title = @"通讯录";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"系统通讯录"])
    {
        SysContactsVC *vc = [[SysContactsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if([title isEqualToString:@"自定义通讯录"])
    {
        CustomContactsVC *vc = [[CustomContactsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
