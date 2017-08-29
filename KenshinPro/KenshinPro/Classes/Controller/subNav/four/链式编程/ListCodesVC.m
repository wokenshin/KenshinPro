//
//  ListCodesVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ListCodesVC.h"
#import "Person.h"

//参考 http://www.jianshu.com/p/7017a220f34c
@interface ListCodesVC ()

@end

@implementation ListCodesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self toast:@"看控制台"];
    self.navigationItem.title = @"链式编程";
    
//    [self funcVersion_1];
//    [self funcVersion_2];
    [self funcVersion_3];
    
}

- (void)funcVersion_1
{
    Person *p = [[Person alloc] init];
    [p run];
    [p learn];
    
}

- (void)funcVersion_2
{
    Person *p = [[Person alloc] init];
    [[p run1] learn];
    
}

#pragma mark 最终效果
- (void)funcVersion_3
{
    Person *p = [[Person alloc] init];
    p.runBlock().learnBlock();
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
