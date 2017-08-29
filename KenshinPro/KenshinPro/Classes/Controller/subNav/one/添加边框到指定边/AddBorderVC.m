//
//  AddBorderVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AddBorderVC.h"
#import "UIView+FXW.h"

@interface AddBorderVC ()

@end

@implementation AddBorderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAddBorderVCUI];
    
}

- (void)initAddBorderVCUI
{
    self.navigationItem.title = @"添加边框";
    
    CGFloat size = 100;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(size, size, size, size)];
    topView.backgroundColor = [UIColor yellowColor];
    [topView fxw_addBorder:FXWBorderDirectionTop color:[UIColor redColor] width:0.5];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(size, size*2+10, size, size)];
    leftView.backgroundColor = [UIColor yellowColor];
    [leftView fxw_addBorder:FXWBorderDirectionLeft color:[UIColor redColor] width:0.5];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(size, size*3 + 20, size, size)];
    bottomView.backgroundColor = [UIColor yellowColor];
    [bottomView fxw_addBorder:FXWBorderDirectionBottom color:[UIColor redColor] width:0.5];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(size, size*4 + 30, size, size)];
    rightView.backgroundColor = [UIColor yellowColor];
    [rightView fxw_addBorder:FXWBorderDirectionRight color:[UIColor redColor] width:0.5];
    
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:bottomView];
    [self.view addSubview:rightView];
    
}


@end
