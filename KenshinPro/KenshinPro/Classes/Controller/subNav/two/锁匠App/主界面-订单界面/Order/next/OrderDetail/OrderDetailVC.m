//
//  OrderDetailVC.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OrderDetailVC.h"

@interface OrderDetailVC ()

@end

@implementation OrderDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initOrderDetailUI];
}

- (void)initOrderDetailUI
{
    self.navigationItem.title = @"订单详情";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}

@end
