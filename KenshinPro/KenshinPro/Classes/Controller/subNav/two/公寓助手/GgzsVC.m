//
//  GgzsVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GgzsVC.h"
#import "FTPopOverMenu.h"
#import "GYZSCtrlVC.h"

@interface GgzsVC ()


@end

@implementation GgzsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"公寓助手";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    
    //事件
    [rightBtn addTarget:self action:@selector(clickRightNavBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
}


- (void)clickRightNavBtn:(id)sender
{
    //gitHub FTPopOverMenu [还可以添加图片]
    [FTPopOverMenu showForSender:sender
                   withMenuArray:@[@"添加设备", @"添加员工", @"呵了个呵", @"阿呆"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}

#pragma mark - 公寓助手-控制界面
- (IBAction)clickBtnPushGYZSCtrlVC:(id)sender
{
    GYZSCtrlVC *vc = [[GYZSCtrlVC alloc] init];
    vc.fxw_isDisablePopGesture = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
