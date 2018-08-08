//
//  UIImage+Runtime.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "UIImage+Runtime.h"
#import <objc/message.h>

@implementation UIImage (Runtime)

/**
 load方法: 把类加载进内存的时候调用,只会调用一次
 方法应先交换，再去调用
 */
+ (void)load
{
    // 1.获取 imageNamed方法地址
    Method imageNamedMethod    = class_getClassMethod(self, @selector(imageNamed:));// class_getClassMethod（获取某个类的方法）
    Method ln_imageNamedMethod = class_getClassMethod(self, @selector(ln_imageNamed:));// 2.获取 ln_imageNamed方法地址
    
    // 3.交换方法地址，相当于交换实现方式;「method_exchangeImplementations 交换两个方法的实现」
    method_exchangeImplementations(imageNamedMethod, ln_imageNamedMethod);
    
    
    //总结：我们所做的就是在方法调用流程第三步的时候，交换两个方法的地址指向。
    //而且我们改变指向的操作，要在系统的imageNamed:方法调用前，所以将代码写在了分类的load方法里。最后当运行的时候系统的方法就会去找我们的方法的实现
}

/**
 看清楚下面是不会有死循环的
 调用 imageNamed => ln_imageNamed
 调用 ln_imageNamed => imageNamed
 */
// 加载图片 且 带判断是否加载成功
+ (UIImage *)ln_imageNamed:(NSString *)name
{
    UIImage *image = [UIImage ln_imageNamed:name];
    if (image)
    {
//        NSLog(@"runtime添加额外功能--加载成功");
    }
    else
    {
//        NSLog(@"runtime添加额外功能--加载失败");
    }
    return image;
    
}

/**
 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super
 所以第二步，我们要 自己实现一个带有扩展功能的方法.
 + (UIImage *)imageNamed:(NSString *)name {
 
 }
 */





@end
