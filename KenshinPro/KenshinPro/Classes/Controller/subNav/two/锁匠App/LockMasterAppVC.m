//
//  LockMasterAppVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "LockMasterAppVC.h"
#import "OrderVC.h"
#import "OrderVC2.h"

@interface LockMasterAppVC ()

@end

@implementation LockMasterAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initLockMasterAppVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"锁匠App 接单界面" andDetail:@"分段选择 普遍效果"];
    [self addDataWithTitle:@"锁匠App 接单界面2" andDetail:@"分段选择 消息中心效果 segment"];
    
}

- (void)initLockMasterAppVCUI
{
    self.navigationItem.title = @"锁匠App";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"锁匠App 接单界面"])
    {
        OrderVC *vc = [[OrderVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
    if ([title isEqualToString:@"锁匠App 接单界面2"])
    {
        OrderVC2 *vc = [[OrderVC2 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
