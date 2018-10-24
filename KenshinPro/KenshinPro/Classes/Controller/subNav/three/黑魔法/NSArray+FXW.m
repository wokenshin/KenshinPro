//
//  NSArray+FXW.m
//  KenshinPro
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "NSArray+FXW.h"
#import <objc/runtime.h>

@implementation NSArray (FXW)

+ (void)load {
    
    //进行方法互换
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod   = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
    
}


/**
 逻辑 符合调教就调用原本的方法，不符合条件就做对应的处理

 @param index 数组下标
 @return 返回结果
 */
- (id)lxz_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self lxz_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self lxz_objectAtIndex:index];//这里实际上是调用的 objectAtIndex:
    }
}

@end
