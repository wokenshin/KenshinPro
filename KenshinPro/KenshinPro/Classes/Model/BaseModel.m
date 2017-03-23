//
//  BaseModel.m
//  LongDaUser
//
//  Created by kenshin van on 2017/3/9.
//  Copyright © 2017年 kenshin van. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


- (instancetype)initModel:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}


+ (instancetype)model:(NSDictionary *)dic
{
    return [[self alloc] initModel:dic];

}

@end
