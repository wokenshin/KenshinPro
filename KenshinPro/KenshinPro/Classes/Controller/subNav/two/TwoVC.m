//
//  TwoVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"two";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
