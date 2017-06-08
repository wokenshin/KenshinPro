//
//  DesignModeVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/7.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DesignModeVC.h"


/**
  学习推荐：  http://design-patterns.readthedocs.io/
  学习推荐：  http://blog.csdn.net/lovelion/article/details/17517213
 */
@interface DesignModeVC ()

@end

@implementation DesignModeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDesignModeVCUI];
    [self toastBottom:@"暂时毛都没有"];
    
}

- (void)initDesignModeVCUI
{
    self.navigationItem.title = @"设计模式";
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
