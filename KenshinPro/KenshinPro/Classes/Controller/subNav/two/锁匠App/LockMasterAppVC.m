//
//  LockMasterAppVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "LockMasterAppVC.h"
#import "SwitchModeVC.h"
#import "XibSelectedBtnImgVC.h"
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
    [self addDataWithTitle:@"界面-情景模式" andDetail:@"ddzm - Masonry 布局 模态显示 "];
    [self addDataWithTitle:@"xib-按钮设置选中状态时的图片" andDetail:@"ddzm - 切换电子锁体"];
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
    if ([title isEqualToString:@"界面-情景模式"])
    {
        SwitchModeVC *vc = [[SwitchModeVC alloc] init];
        
        //        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        //vcm1.stringPara =@"value";// 传参
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        return;
    }
    if ([title isEqualToString:@"xib-按钮设置选中状态时的图片"])
    {
        XibSelectedBtnImgVC *vc = [[XibSelectedBtnImgVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
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
