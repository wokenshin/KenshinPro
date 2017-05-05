//
//  HideNavDividingLineVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "HideNavDividingLineVC.h"

@interface HideNavDividingLineVC ()

@end

@implementation HideNavDividingLineVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"隐藏导航栏分割线";
    self.view.backgroundColor = colorHomeBlue;//将背景色设置成当行蓝的颜色
    
    //注意：当这样设置的时候，控制器中的UI frame的y值 会自动下移 不知道为什么
    //因为直接给导航栏设置颜色 会被系统的导航栏加一层蒙版颜色会和原先设置的颜色存在色差
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];

}

- (IBAction)clickButtonHidenNavLine:(id)sender
{
    //设置一张图片作为导航栏的背景
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
