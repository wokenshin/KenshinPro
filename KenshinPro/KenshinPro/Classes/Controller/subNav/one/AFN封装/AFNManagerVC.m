//
//  AFNManagerVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFNManagerVC.h"
#import "AFNMCVC.h"
#import "AFN_FXWDemoVC.h"

@interface AFNManagerVC ()

@end

@implementation AFNManagerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initLockMasterAppVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"AFN_FXW" andDetail:@"通用的AFN 网络请求 from kenshin"];
    [self addDataWithTitle:@"AFN_MC" andDetail:@"在MC工作的时候对AFN的封装"];
    [self addDataWithTitle:@"AFN_HS" andDetail:@"在HS工作的时候对AFN的封装"];
    
    
}

- (void)initLockMasterAppVCUI
{
    self.navigationItem.title = @"锁匠App";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"AFN_MC"])
    {
        AFNMCVC *vc = [[AFNMCVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"AFN_HS"])
    {
        [self toast:@"下次添加... AFN_HS"];
        return;
    }
    if ([title isEqualToString:@"AFN_FXW"])
    {
        AFN_FXWDemoVC *vc = [[AFN_FXWDemoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
