//
//  CodingRuntime.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CodingRuntime.h"

@implementation CodingRuntime

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_country forKey:@"country"];
    [aCoder encodeObject:_name    forKey:@"name"];
    [aCoder encodeObject:_gender  forKey:@"gender"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.name    = [aDecoder decodeObjectForKey:@"name"];
        self.gender  = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
    
}

@end
