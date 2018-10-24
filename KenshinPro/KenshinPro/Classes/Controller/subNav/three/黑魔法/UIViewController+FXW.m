//
//  UIViewController+FXW.m
//  KenshinPro
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "UIViewController+FXW.h"
#import <objc/runtime.h>

/**
 这是一个控制器分类
 参考：https://www.jianshu.com/p/ff19c04b34d0
 */
@implementation UIViewController (FXW)


+ (void)load{

    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod   = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    /**
     我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
     */
    if (!class_addMethod([self class], @selector(swizzlingViewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))){
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad{
    
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
        NSLog(@"统计打点 : %@", self.class);
    }
    [self swizzlingViewDidLoad];//递归？ 不会，由于这里进行了方法互换，所以 调用swizzlingViewDidLoad 实际 执行的是 viewDidLoad
    
}


@end
