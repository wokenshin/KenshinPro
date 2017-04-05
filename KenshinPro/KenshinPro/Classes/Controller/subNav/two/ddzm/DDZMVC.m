//
//  DDZMVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/31.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DDZMVC.h"
#import "ControlMenuVC.h"

@interface DDZMVC ()

@end

@implementation DDZMVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initLockMasterAppVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"菜单-CollectionVew" andDetail:@"ddzm - 控制页面底部菜单"];
    [self addDataWithTitle:@"读取二进制文件" andDetail:@"DFU 固件升级"];
    
}

- (void)initLockMasterAppVCUI
{
    self.navigationItem.title = @"ddzm";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"菜单-CollectionVew"])
    {
        ControlMenuVC *vc = [[ControlMenuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"读取二进制文件"])
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.m2" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
