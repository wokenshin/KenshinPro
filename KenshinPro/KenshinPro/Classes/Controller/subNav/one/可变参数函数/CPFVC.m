//
//  CPFVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/2/8.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CPFVC.h"


@interface CPFVC ()

@end

@implementation CPFVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"可变参数函数";
    [self ken_print:@"1", @"2", @"3", @"4", nil];
    
    
}

//个人感觉下面的代码有点垃圾
- (void)ken_print:(NSString *)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
    if (firstArg) {
        // 取出第一个参数
        NSLog(@"%@", firstArg);
        // 定义一个指向个数可变的参数列表指针；
        va_list args;
        // 用于存放取出的参数
        NSString *arg;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, firstArg);
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        while ((arg = va_arg(args, NSString *))) {
            NSLog(@"%@", arg);
        }
        
        // 清空参数列表，并置参数指针args无效
        va_end(args);
    }
}




- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
