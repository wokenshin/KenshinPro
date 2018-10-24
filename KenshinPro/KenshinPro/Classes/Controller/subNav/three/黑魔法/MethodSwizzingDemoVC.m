//
//  MethodSwizzingDemoVC.m
//  KenshinPro
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "MethodSwizzingDemoVC.h"
#import "UIViewController+FXW.h"
#import "NSArray+FXW.h"

@interface MethodSwizzingDemoVC ()

@end

@implementation MethodSwizzingDemoVC

//这里只是作为一个初步了解 参考：https://www.jianshu.com/p/ff19c04b34d0
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"黑魔法";
    
//    [self test1];
    [self test2];
}

- (void)test1{
    [self swizzlingViewDidLoad];
    NSArray *arr = @[@"kenshin", @"xun", @"toma"];
    NSString *a = [arr objectAtIndex:3];//由于做了method swizzling 这里并不会崩溃 a == nil
    NSLog(@">>>>>>>>> a = %@", a);
}


/**
 这里通过交换方法，可以发现交换之后的方法再次交换又变回了之前各自原本对应的方法
 通过内存地址可以判断如上结论
 */
- (void)test2{
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    method_exchangeImplementations(fromMethod, toMethod);
    
    NSLog(@"%p", method_getImplementation(fromMethod));
    NSLog(@"%p", method_getImplementation(toMethod));
    
}

- (id)lxz_objectAtIndex:(NSUInteger)index{
    return nil;
}

@end
