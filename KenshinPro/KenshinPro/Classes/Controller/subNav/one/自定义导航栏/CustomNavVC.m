//
//  CustomNav.m
//  KenshinPro
//
//  Created by kenshin on 17/3/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CustomNavVC.h"
#import "NavBarCustomVC.h"

@interface CustomNavVC ()

@end

@implementation CustomNavVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initMenusVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"隐藏导航栏分割线" andDetail:@"xxxx"];
    [self addDataWithTitle:@"自定义导航栏-kenshinApp" andDetail:@"xxxxxx"];
    
}

- (void)initMenusVCUI
{
    self.navigationItem.title = @"各种菜单";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"自定义导航栏-kenshinApp"])
    {
        NavBarCustomVC *vc = [[NavBarCustomVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
