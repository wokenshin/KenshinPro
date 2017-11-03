//
//  FXW_SafeAreaVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/2.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_SafeAreaVC.h"

@interface FXW_SafeAreaVC ()

@end

@implementation FXW_SafeAreaVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Safe Area";
    
    WS(ws);
    [self alertSystemTitle:@"fuck" message:@"我不能接受 iPhoneX 的画风，自己google 百度吧" OK:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
