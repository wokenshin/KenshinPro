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

//第三方 腾讯的 bug日志
#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self intoRootVC];
    [self setNavigationBarStyle];
    [self realTimeCheckNetStatus];
    
    /*
     初始化Bugly
     配置好之后 可以在平台上查看 App的崩溃等异常情况 https://bugly.qq.com/
     进行部分配置之后 能够更加快速直观的定位到错误
     */
    [Bugly startWithAppId:@"af50443407"];//只需要这一行代码即可 更高级的用法请参考官网
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application{}
- (void)applicationWillEnterForeground:(UIApplication *)application{}
- (void)applicationDidBecomeActive:(UIApplication *)application{}
- (void)applicationWillTerminate:(UIApplication *)application{}

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
    //设置NavBar背景和前景颜色 'setStatusBarStyle:' is deprecated: first deprecated in iOS 9.0 - Use -[UIViewController preferredStatusBarStyle]
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
                [ws toastBottom:@"网络不可用-未知情况"];
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable://无连接
            {
                ws.netStatus = AFNetworkReachabilityStatusNotReachable;
                [ws toastBottom:@"网络无连接"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://2G 3G 4G
            {
                ws.netStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                [ws toastBottom:@"当前使用流量联网"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
            {
                ws.netStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                [ws toastBottom:@"当前使用WiFi联网"];
            }
                break;
                
            default:
                break;
        }
    }];

}

- (void)toastBottom:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setText:message];
    [toast show];
    
}

@end
