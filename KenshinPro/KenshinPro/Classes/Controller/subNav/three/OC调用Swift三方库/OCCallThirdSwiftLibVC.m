//
//  OCCallThirdSwiftLibVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/13.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OCCallThirdSwiftLibVC.h"
#import "KenshinPro-Swift.h" //OC中调用Swift时记住要导入该头文件

@interface OCCallThirdSwiftLibVC ()

@end

@implementation OCCallThirdSwiftLibVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initOCCallThirdSwiftLibVCUI];
    [self toast:@"屁都没有，等用的时候在写"];
}

- (void)initOCCallThirdSwiftLibVCUI
{
    self.navigationItem.title = @"OC调用Swift三方库";
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
