//
//  MBMJVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/1.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MBMJVC.h"

@interface MBMJVC ()

@end

@implementation MBMJVC

/*
 + (void)showSuccess:(NSString *)success toView:(UIView *)view;
 + (void)showError:(NSString *)error toView:(UIView *)view;
 
 + (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
 
 
 + (void)showSuccess:(NSString *)success;
 + (void)showError:(NSString *)error;
 
 + (MBProgressHUD *)showMessage:(NSString *)message;
 
 + (void)hideHUDForView:(UIView *)view;
 + (void)hideHUD;
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"MB+MJ 分类演示";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
