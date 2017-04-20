//
//  MCClientVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MCClientVC.h"
#import "EvaluateStarsVC.h"

@interface MCClientVC ()

@end

@implementation MCClientVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMCClientVCUI];
    [self loadData];
}

- (void)initMCClientVCUI
{
    self.navigationItem.title = @"MC-Client";
    [self.view addSubview:self.tableView];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"星星评级" andDetail:@"MC的评论功能"];
    
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    
    if ([title isEqualToString:@"星星评级"])
    {
        EvaluateStarsVC *vc = [[EvaluateStarsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
