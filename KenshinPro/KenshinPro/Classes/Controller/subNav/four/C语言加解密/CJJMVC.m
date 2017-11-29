//
//  CJJMVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CJJMVC.h"
#include "FXWCode.h"

@interface CJJMVC ()

@end

@implementation CJJMVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"C加解密";
    
    //NSString转char * /const char *
    char *cStr = [@"kenshin" UTF8String];
    
    //char转 NSString
    NSString *string = [NSString stringWithFormat:@"%s", cStr];
    string = nil;
    
    char *c = test(cStr);
    NSLog(@"%@", [NSString stringWithFormat:@"%s", c]);
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
