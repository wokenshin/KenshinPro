//
//  MenusVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MenusVC.h"

@interface MenusVC ()

@end

@implementation MenusVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initMenusVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"Menu1" andDetail:@"侧滑菜单"];
    [self addDataWithTitle:@"Menu2" andDetail:@"底部菜单"];
    [self addDataWithTitle:@"Menu3" andDetail:@"顶部菜单"];
    [self addDataWithTitle:@"Menu4" andDetail:@"弹出菜单"];
    
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
