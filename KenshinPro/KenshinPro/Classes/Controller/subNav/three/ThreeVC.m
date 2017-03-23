//
//  ThreeVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ThreeVC.h"

@interface ThreeVC ()

@end

@implementation ThreeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"three";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
