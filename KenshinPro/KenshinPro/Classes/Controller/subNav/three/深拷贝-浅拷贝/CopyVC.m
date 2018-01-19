//
//  CopyVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/15.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CopyVC.h"

@interface CopyVC ()

@end

@implementation CopyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"深拷贝-浅拷贝";
    //在项目中遇到过坑爹的事情 就是 copy的时候 拷贝到的model中的基本数据类型的值全部都是0 原因可能是新增的属性没有遵守 copy协议，现在不追究，后期有时间补充
    
    
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
