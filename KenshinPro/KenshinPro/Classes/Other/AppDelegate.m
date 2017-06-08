//
//  AppDelegate.m
//  KenshinPro
//
//  Created by kenshin on 17/3/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkReachabilityManager.h"

#import "MainTabBarVC.h"
#import "FXW_Define.h"
#import "AFN_HS.h"

#import "MDToast.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self intoRootVC];
    [self setNavigationBarStyle];
    [self realTimeCheckNetStatus];
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
- (void)intoRootVC
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainTabBarVC *rootVC = [[MainTabBarVC alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
}

#pragma mark 设置导航栏风格
- (void)setNavigationBarStyle
{
    //设置系统状态栏颜色，在plist文件中设置View controller-based status bar appearance 为 NO才能起效
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //设置NavBar背景和前景颜色
    [[UINavigationBar appearance] setBarTintColor:colorDdzmBlueNavBar];
    
    //设置返回文字和图标颜色[系统默认返回按钮]
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置导航条标题颜色和字体大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:FontK(20),
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

#pragma mark 实时监听网络状态
- (void)realTimeCheckNetStatus
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];//打开监测
    
    WS(ws);
    //监测网络状态回调
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown://未知
            {
                ws.netStatus = AFNetworkReachabilityStatusUnknown;
                [ws toast:@"网络不可用-未知情况"];
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable://无连接
            {
                ws.netStatus = AFNetworkReachabilityStatusNotReachable;
                [ws toast:@"网络无连接"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://2G 3G 4G
            {
                ws.netStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                [ws toast:@"当前使用流量联网"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
            {
                ws.netStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                [ws toast:@"当前使用WiFi联网"];
            }
                break;
                
            default:
                break;
        }
    }];

}

- (void)toast:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setGravity:MDGravityCenterVertical | MDGravityCenterHorizontal];
    
    [toast setText:message];
    [toast show];
    
}

- (void)toastBottom:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setText:message];
    [toast show];
    
}

@end
