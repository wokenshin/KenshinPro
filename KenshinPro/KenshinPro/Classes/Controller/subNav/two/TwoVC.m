//
//  TwoVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TwoVC.h"
#import "DDZMVC.h"
#import "LockMasterAppVC.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initLockMasterAppVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"bwzk" andDetail:@"第一个智能设备 socket + 声纹码 App"];
    [self addDataWithTitle:@"jrhhg" andDetail:@"协助开发"];
    [self addDataWithTitle:@"zyhcxf" andDetail:@"协助开发"];
    [self addDataWithTitle:@"anyChat多人聊天" andDetail:@"半成品"];
    [self addDataWithTitle:@"MC-Client" andDetail:@"GY-像样一点的电商App"];
    [self addDataWithTitle:@"MC-Service" andDetail:@"GY-像样一点的电商App"];
    [self addDataWithTitle:@"ddzm" andDetail:@"蓝牙+TCP 智能锁App"];
    [self addDataWithTitle:@"锁匠App" andDetail:@"智能锁 服务端"];
    
    
}

- (void)initLockMasterAppVCUI
{
    self.navigationItem.title = @"Projectes";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"ddzm"])
    {
        DDZMVC *vc = [[DDZMVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"锁匠App"])
    {
        LockMasterAppVC *vc = [[LockMasterAppVC alloc] init];
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
