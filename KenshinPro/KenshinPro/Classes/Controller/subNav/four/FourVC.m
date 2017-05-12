//
//  FourVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FourVC.h"

@interface FourVC ()

@end

@implementation FourVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"高级";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
