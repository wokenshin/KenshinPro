//
//  AFNMCVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFNMCVC.h"
#import "AFN_MC.h"

@interface AFNMCVC ()

@end

@implementation AFNMCVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"MC AFN封装";
    
}

- (IBAction)getVerifyCode:(id)sender
{
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc] init];
    [parmsDic setObject:@"18385099999" forKey:@"phoneNo"];
    
    [AFN_MC postWithMethod:@"getValidCode"
                    module:@"sms"
                    params:parmsDic
    resultBlock:^(BOOL success, NSDictionary *resultDic, NSString *errorMsg) {
        if (success)
        {
            NSString *code = [resultDic objectForKey:@"validCode"];
            NSLog(@"验证码是 %@", code);
        }
        else
        {
            [self toast:errorMsg];
        }
        
    }];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
