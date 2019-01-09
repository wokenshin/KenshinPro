//
//  FourLines.m
//  KenshinPro
//
//  Created by apple on 2019/1/9.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FourLines.h"

static NSString * const kLineKey = @"kLineKey";
@implementation FourLines

#pragma mark - Coding
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLineKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.lines forKey:kLineKey];
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone{
    FourLines *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}
@end
