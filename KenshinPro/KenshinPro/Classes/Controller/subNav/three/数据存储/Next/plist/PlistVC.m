//
//  PlistVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/25.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "PlistVC.h"

@interface PlistVC ()

@end

@implementation PlistVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPlistVCUI];
    
}

- (void)initPlistVCUI
{
    self.navigationItem.title = @"属性列表的存储";
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
