//
//  SetUICornerRadiusVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SetUICornerRadiusVC.h"
#import "UIView+FXW.h"
@interface SetUICornerRadiusVC ()

@end

@implementation SetUICornerRadiusVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 100, 100)];
    lab.backgroundColor = [UIColor yellowColor];
    lab.cornerRadius = 10;
    [self.view addSubview:lab];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
