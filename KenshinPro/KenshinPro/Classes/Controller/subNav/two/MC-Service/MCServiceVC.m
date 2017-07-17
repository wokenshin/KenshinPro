//
//  MCServiceVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/7/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MCServiceVC.h"

@interface MCServiceVC ()

@end

@implementation MCServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMCClientVCUI];
    [self loadData];
}

- (void)initMCClientVCUI
{
    self.navigationItem.title = @"MC-Client";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"各种图表" andDetail:@"数据分布图标"];
    
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    
    if ([title isEqualToString:@"各种图表"])
    {
//        EvaluateStarsVC *vc = [[EvaluateStarsVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
