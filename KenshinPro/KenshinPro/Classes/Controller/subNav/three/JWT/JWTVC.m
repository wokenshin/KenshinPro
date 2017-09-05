//
//  JWTVC.m
//  KenshinPro
//
//  Created by kenshin on 17/5/22.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "JWTVC.h"
#import "JWTTools.h"

static NSString *secretKey = @"UzI1NiIsLCJuYmYiOTy4w58$2a$1";

static NSString *jwt = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDMwNTE0OTcsImlhdCI6MTQ5NTEwMjY5NywiaXNzIjoiYXBwLm0ybWtleS5jb20iLCJzdWIiOiI1OGU1OWEyYjY1NTk4YjBjM2ExMjVkYzkifQ.sfdyjHzmQJlCNP5bfsQwaNf4wyql40oaVTxE1Vwo8f0";

@interface JWTVC ()

@end

@implementation JWTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JWT";
    
}

- (IBAction)clickJWTButton:(id)sender
{
    NSDictionary *dic = [JWTTools verifyJWT:jwt secretKey:secretKey];
    if (dic)
    {
        [self toast:[NSString stringWithFormat:@"%@", dic]];
    }
    else
    {
        [self toast:@"JWT 验证失败"];
    }
    
    
}




- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
