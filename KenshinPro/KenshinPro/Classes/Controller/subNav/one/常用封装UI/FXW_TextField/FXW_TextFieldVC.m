//
//  FXW_TextFieldVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_TextFieldVC.h"

@interface FXW_TextFieldVC ()

@end

@implementation FXW_TextFieldVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"FXW_TextField";
    self.view.backgroundColor = [UIColor whiteColor];
    FXW_TextField *txt = [[FXW_TextField alloc] initWithFrame:CGRectMake(30, 84, screenWidth - 60, 36)];
    txt.backgroundColor = [UIColor orangeColor];
//    txt.leftMargin = 20;
    txt.placeholder = @"看看是啥样子";
    
    [self.view addSubview:txt];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
