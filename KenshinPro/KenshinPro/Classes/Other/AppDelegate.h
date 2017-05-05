//
//  AppDelegate.h
//  KenshinPro
//
//  Created by kenshin on 17/3/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 App的网络状态
 */
typedef NS_ENUM(NSInteger, AppNetStatus) {
    AppNetStatusUnknown          = -1, //未知网络状态
    AppNetStatusNotReachable     = 0,  //网络不可用
    AppNetStatusViaWWAN          = 1,  //流量 2G 3G 4G...
    AppNetStatusWiFi             = 2,  //WiFi
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) AppNetStatus              netStatus;

@end

