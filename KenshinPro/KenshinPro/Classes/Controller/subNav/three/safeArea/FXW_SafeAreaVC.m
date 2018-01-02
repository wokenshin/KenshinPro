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
    
    CGFloat statusH = [[UIApplication sharedApplication] statusBarFrame].size.height;//20 or 44
    NSLog(@"statusHeight:%f", statusH);
    
    //UI在 xib中创建 xcode 设置iOS兼容最低版本为iOS9或以上 xib中会自动生成safeArea 这样在xib中创建的UI会保留在安全区范围内
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
