//
//  MenusVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MenusVC.h"
#import "BaiDuBottomMenu.h"
#import "DDZM_BottomMenuVC.h"
#import "DdzmLeftMenuVC.h"

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
    
    [self addDataWithTitle:@"底部菜单-ddzm" andDetail:@"动画来实现的"];
    [self addDataWithTitle:@"底部菜单-百度" andDetail:@"collectionView 感觉没有我的xib菜单好用 可读性差"];
    [self addDataWithTitle:@"底部菜单-ldkd" andDetail:@"滚动视图"];
    
    [self addDataWithTitle:@"左侧菜单-ddzm" andDetail:@"封装的不好"];
    
    [self addDataWithTitle:@"顶部菜单-" andDetail:@"顶部菜单"];
    
    [self addDataWithTitle:@"弹出菜单-" andDetail:@"弹出菜单"];
    
}

- (void)initMenusVCUI
{
    self.navigationItem.title = @"各种菜单";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"底部菜单-ddzm"])
    {
        DDZM_BottomMenuVC *vc = [[DDZM_BottomMenuVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"左侧菜单-ddzm"])
    {
        DdzmLeftMenuVC *vc = [[DdzmLeftMenuVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"底部菜单-ldkd"])
    {
        
        return;
    }
    if ([title isEqualToString:@"底部菜单-百度"])
    {
        BaiDuBottomMenu *vc = [[BaiDuBottomMenu alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
