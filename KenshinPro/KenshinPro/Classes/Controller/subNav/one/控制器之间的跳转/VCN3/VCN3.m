//
//  VCN3.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCN3.h"
#import "VCN4.h"

@interface VCN3 ()

@end

@implementation VCN3

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVCN3UI];
    
}

- (void)initVCN3UI
{
    self.navigationItem.title = @"VCN3";
    
    
}
- (IBAction)pushVCN4:(id)sender
{
    VCN4 *vc = [[VCN4 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
