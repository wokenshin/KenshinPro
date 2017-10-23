//
//  RunloopStatusFXWVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RunloopStatusFXWVC.h"

@interface RunloopStatusFXWVC ()

@end

@implementation RunloopStatusFXWVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Runloop状态";
    //下边我们通过代码来监听下RunLoop中的状态改变
    
    // 创建观察者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"监听到RunLoop发生改变---%zd", activity);
    });
    
    // 添加观察者到当前RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放observer，最后添加完需要释放掉
    CFRelease(observer);
    
    /*
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),               // 即将进入Loop：1
     kCFRunLoopBeforeTimers = (1UL << 1),        // 即将处理Timer：2
     kCFRunLoopBeforeSources = (1UL << 2),       // 即将处理Source：4
     kCFRunLoopBeforeWaiting = (1UL << 5),       // 即将进入休眠：32
     kCFRunLoopAfterWaiting = (1UL << 6),        // 即将从休眠中唤醒：64
     kCFRunLoopExit = (1UL << 7),                // 即将从Loop中退出：128
     kCFRunLoopAllActivities = 0x0FFFFFFFU       // 监听全部状态改变
     };
     
     可以看到RunLoop的状态在不断的改变，最终变成了状态 32，也就是即将进入睡眠状态，说明RunLoop之后就会进入睡眠状态。
     */
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
