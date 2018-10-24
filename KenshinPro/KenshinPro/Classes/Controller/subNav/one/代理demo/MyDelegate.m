//
//  MyDelegate.m
//  KenshinPro
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "MyDelegate.h"

@implementation MyDelegate

- (void)doSomething{
    
    //判断是否绑定代理
    if (_delegate != nil) {
        //判断调用本方法的类的实例是否实现了代理
        if ([_delegate respondsToSelector:@selector(myDelegateOptional)]) {
            [_delegate myDelegateOptional];//触发代理->实现代理方法的方法会被触发
        }
        else{
            NSLog(@"没有实现可选代理");
        }
        
        //判断调用本方法的类的实例是否实现了代理
        if ([_delegate respondsToSelector:@selector(myDelegateRequired)]) {
            [_delegate myDelegateRequired];//触发代理
        }
        else{
            NSLog(@"没有实现必选代理");
        }
    }
    else{
        NSLog(@"没有绑定代理！无法触发代理方法");
    }
    
    
}

@end
