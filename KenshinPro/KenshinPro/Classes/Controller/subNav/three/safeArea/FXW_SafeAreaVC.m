//
//  FXW_SafeAreaVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/2.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_SafeAreaVC.h"

@interface FXW_SafeAreaVC ()

@end

@implementation FXW_SafeAreaVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"safe area";
    [self toastBottom:@"看控制台"];
    
    /*
       iOS 7 之后苹果给 UIViewController 引入了 topLayoutGuide 和 bottomLayoutGuide 两个属性来描述不希望被透明的状态栏或者导航栏遮挡的最高位置
     (status bar, navigation bar, toolbar, tab bar 等)。
     这个属性的值是一个 length 属性( topLayoutGuide.length)。
     这个值可能由当前的 ViewController 或者 NavigationController 或者 TabbarController 决定
     */
    
    CGFloat fxw_h_top    = self.topLayoutGuide.length;
    CGFloat fxw_h_bottom = self.bottomLayoutGuide.length;
    
    NSString *tips_top    = [NSString stringWithFormat:@"topLayoutGuide : %f", fxw_h_top];
    NSString *tips_bottom = [NSString stringWithFormat:@"bottomLayoutGuide : %f", fxw_h_bottom];
    
    NSLog(@"%@", tips_top);
    NSLog(@"%@", tips_bottom);
    
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
