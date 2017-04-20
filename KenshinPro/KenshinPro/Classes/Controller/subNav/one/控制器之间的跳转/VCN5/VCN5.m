//
//  VCN5.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCN5.h"

@interface VCN5 ()

@end

@implementation VCN5

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVCN5UI];
    [self toast:@"隐藏了导航栏，但是是在导航控制器中的一个VC"];
    
}

- (void)initVCN5UI
{
    self.navigationItem.title = @"VCN5";
    
}

- (IBAction)dismiss3:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
