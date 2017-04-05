//
//  CommonUIVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CommonUIVC.h"
#import "AlertVC2.h"
#import "FXW_TextFieldVC.h"

@interface CommonUIVC ()

@end

@implementation CommonUIVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initMenusVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"FXW_Button" andDetail:@"block回调实现事件监听"];
    [self addDataWithTitle:@"FXW_Control" andDetail:@"block回调实现事件监听"];
    [self addDataWithTitle:@"FXW_TextField" andDetail:@"对文本的监听，长度的限制"];
    [self addDataWithTitle:@"FXW_TextView" andDetail:@"对文本的监听，长度的限制"];
    [self addDataWithTitle:@"PopSelect" andDetail:@"弹框选择 是一个table 美观上差一些"];
    [self addDataWithTitle:@"系统弹框+微信sheet" andDetail:@"kenshinApp中的内容"];
    
}

- (void)initMenusVCUI
{
    self.navigationItem.title = @"各种菜单";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"FXW_Button"])
    {
        
        return;
    }
    if ([title isEqualToString:@"FXW_Control"])
    {
        
        return;
    }
    if ([title isEqualToString:@"FXW_TextField"])
    {
        FXW_TextFieldVC *vc = [[FXW_TextFieldVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"FXW_TextView"])
    {
        
        return;
    }
    if ([title isEqualToString:@"PopSelect"])
    {
        PopSelect* alertSelect = [[PopSelect alloc] initWithFrame:self.view.frame];
        [self.view  addSubview:alertSelect];
        
        WS(ws);
        NSArray *arr = @[@"ONE", @"TWO", @"THREE", @"FOUR"];
        [alertSelect alertTableview:arr title:@"请选择XXX" resultBlock:^(int tag) {
            [ws toast:arr[tag]];
        }];
        return;
    }
    if ([title isEqualToString:@"系统弹框+微信sheet"])
    {
        AlertVC2 *vc = [[AlertVC2 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
