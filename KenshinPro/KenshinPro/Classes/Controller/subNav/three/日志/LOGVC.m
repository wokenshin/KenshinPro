//
//  LOGVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/19.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

//下面这段宏扎心勒 之前都不知道是这个意思 也不知道这里的 DEBUG 是系统的
//意思是:只在debug的时候输出, release的时候不输出
#ifndef DEBUG
#define NSLog(...)
#endif

//意思是:只在debug的时候输出, release的时候不输出
#ifdef DEBUG
#define TestLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define TestLog(...)
#endif
#import "LOGVC.h"

@interface LOGVC ()

@end

@implementation LOGVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSLog";
    
    
    
    
}

#pragma mark 方法输出
- (IBAction)functionLog:(id)sender
{
    [self test];
}

#pragma mark 宏定义输出
- (IBAction)defineLog:(id)sender
{
    TestLog(@"这是宏定义输出的日志");
    
}

- (void)test
{
    //类名及函数(方法)名
    NSLog(@"方法 %s", __func__);
    NSLog(@"方法 %s",__FUNCTION__);
    NSLog(@"方法 %s",__PRETTY_FUNCTION__);
    
    //行数
    NSLog(@"%d",__LINE__);
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
