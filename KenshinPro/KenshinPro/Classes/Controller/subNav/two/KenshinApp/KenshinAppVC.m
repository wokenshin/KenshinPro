//
//  KenshinAppVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "KenshinAppVC.h"

@interface KenshinAppVC ()

@end

@implementation KenshinAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initKenshinAppVCUI];
    [self loadData];
    
}

- (void)initKenshinAppVCUI
{
    self.navigationItem.title = @"KenshinApp";
    [self.view addSubview:self.tableView];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"锁匠App" andDetail:@"智能锁 服务端 2017-03"];
    
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"锁匠App"])
    {
//        LockMasterAppVC *vc = [[LockMasterAppVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
