//
//  GestureLockVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/6.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GestureLockVC.h"
#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"


@interface GestureLockVC ()

@end

@implementation GestureLockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"手势解锁";
    
}

//设置手势密码
- (IBAction)clickSettiingGesturePwd:(id)sender
{
    GestureViewController *gestureVc = [[GestureViewController alloc] init];
    gestureVc.type = GestureViewControllerTypeSetting;
    [self.navigationController pushViewController:gestureVc animated:YES];
    
}

//登录手势密码
- (IBAction)loginGesturePwd:(id)sender
{
    if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length])
    {
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        [gestureVc setType:GestureViewControllerTypeLogin];
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
    else
    {
        [self alertSystemTitle:@"提示" message:@"暂未设置手势密码，请先设置手势密码" OK:^{
        }];
    }

}

//验证手势密码
- (IBAction)clickVerifyGesturePwd:(id)sender
{
    GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
    [self.navigationController pushViewController:gestureVerifyVc animated:YES];
}

//修改手势密码
- (IBAction)clickChangeGesturePwd:(id)sender
{
    GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
    gestureVerifyVc.isToSetNewGesture = YES;
    [self.navigationController pushViewController:gestureVerifyVc animated:YES];
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
