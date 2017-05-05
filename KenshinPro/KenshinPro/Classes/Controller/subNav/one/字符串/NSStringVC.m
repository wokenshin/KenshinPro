//
//  NSStringVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSStringVC.h"

@interface NSStringVC ()

@end

@implementation NSStringVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"字符串";
}

#pragma mark 字符串->字节
- (IBAction)clickButtonStrToByte:(id)sender
{
    //参考:http://blog.csdn.net/u012198553/article/details/40595825
    //不要问我这有什么用，项目里面用到的。 有时间还是去看下关于 二进制，字节啥的东西吧。基础的东西全忘了
    
    NSString *str = [NSString stringWithFormat:@"HelloWorld"];
    NSData *dataStr = [str dataUsingEncoding: NSUTF8StringEncoding];
//    dataStr.bytes
    [self toastBottom:@"sta->data->data.bytes"];
    
    
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
