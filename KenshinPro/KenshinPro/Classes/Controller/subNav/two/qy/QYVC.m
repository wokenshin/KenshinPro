//
//  QYVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "QYVC.h"
#import "DeviceManageVC.h"

@interface QYVC ()

@end

@implementation QYVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initQYVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"UICollectionView-设备管理界面" andDetail:@"在cell内部设置margin的方法"];
    
    
}

- (void)initQYVCUI
{
    self.navigationItem.title = @"QYApp";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"UICollectionView-设备管理界面"])
    {
        DeviceManageVC *vc = [[DeviceManageVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
    [self toast:@"什么鬼？"];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
