//
//  Person.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)run
{
    NSLog(@"run");
}

- (void)learn
{
    NSLog(@"learn");
}

- (Person *)run1
{
    NSLog(@"run1");
    return [[Person alloc] init];
}

- (Person *)learn2
{
    NSLog(@"learn1");
    return [[Person alloc] init];
}

- (Person* (^)())runBlock
{
    Person* (^block)() = ^() {
        NSLog(@"runBlock");
        return self;
    };
    return block;
}

- (Person* (^)())learnBlock
{
    Person* (^block)() = ^() {
        NSLog(@"learnBlock");
        return self;
    };
    return block;
}

#pragma mark - 用于runtime 的 私有方法
- (void)fxw_eat
{
    NSLog(@"kenshin 正在吃午饭");
}

- (void)fxw_run:(NSString *)str
{
    NSLog(@"kenshin 和 %@ 一起跑步", str);
}

@end
