//
//  AppDelegate.m
//  KenshinPro
//
//  Created by kenshin on 17/3/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarVC.h"
#import "FXW_Define.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self intoFirstVC];
    [self setNavigationBarStyle];
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark - 设置根控制器
- (void)intoFirstVC
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainTabBarVC *rootVC = [MainTabBarVC new];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
}

#pragma mark 设置导航栏风格
- (void)setNavigationBarStyle
{
    //设置系统状态栏颜色，在plist文件中设置View controller-based status bar appearance 为 NO才能起效
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //设置NavBar背景和前景颜色
    [[UINavigationBar appearance] setBarTintColor:colorBlueNavBar];
    
    //设置返回文字和图标颜色[系统默认返回按钮]
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置导航条标题颜色和字体大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:FontK(20),
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}


@end
