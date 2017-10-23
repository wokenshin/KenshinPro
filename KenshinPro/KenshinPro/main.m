//
//  main.m
//  KenshinPro
//
//  Created by kenshin on 17/3/15.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //UIApplicationMain函数内部帮我们开启了主线程的RunLoop，UIApplicationMain内部拥有一个无线循环的代码
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
