//
//  RespondCodesVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RespondCodesVC.h"

@interface RespondCodesVC ()

@end

@implementation RespondCodesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self toast:@"待更新..."];
    self.navigationItem.title = @"响应式编程";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
