//
//  JWTTools.m
//  SmartDevice
//
//  Created by kenshin on 17/5/22.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import "JWTTools.h"
#import "JWT.h"

@implementation JWTTools

+ (NSDictionary *)verifyJWT:(NSString *)jsonWebToken secretKey:(NSString *)sercetKey
{
    
    JWTBuilder *builder = [JWT decodeMessage:jsonWebToken].secret(sercetKey).whitelist(@[@"HS256", @"none"]);
    
    NSDictionary *decoded = builder.decode;
    
    if (builder.jwtError)//如果 secret 过期的话 就会走这里的error
    {
        return nil;
    }
    else
    {
        NSDictionary *payload = decoded[@"payload"];
        NSDictionary *header = decoded[@"header"];
        NSArray *tries = decoded[@"tries"];// will be evolded into something appropriate later.
        payload = nil;
        header = nil;
        tries = nil;
        
        return decoded;
    }
    
}

@end
