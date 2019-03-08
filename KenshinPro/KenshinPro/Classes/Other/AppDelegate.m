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
    NSLog(@"%@", NSStringFromSelector(_cmd));//内置变量，始终包含当前方法的选择器
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

////黑屏
//- (void)blackScreenOn:(BOOL)isOn{
//    [UIApplication sharedApplication].keyWindow.hidden = isOn;
//}

#pragma mark - 设置根控制器
- (void)intoRootVC
{
    [[UITabBar appearance] setTranslucent:NO];//fxw_修复bug iOS12.1 tabbar pop时为止偏移
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

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Demo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support
//感觉没什么暖用 这里的代码与 one->精通iOS开发第六版->数据持久化基础知识->CoreData 相关
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
