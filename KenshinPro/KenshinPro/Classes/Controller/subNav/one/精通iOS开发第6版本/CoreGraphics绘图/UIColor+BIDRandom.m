//
//  UIColor+BIDRandom.m
//  KenshinPro
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "UIColor+BIDRandom.h"

#define ARC4RANDOM_MAX 0x100000000LL
@implementation UIColor (BIDRandom)

+ (UIColor*)randomColor{
    //这样计算出来的red的随机值将在 [0.0, 1.0]之间
    CGFloat red   = (CGFloat)arc4random()/(CGFloat)ARC4RANDOM_MAX;
    CGFloat green = (CGFloat)arc4random()/(CGFloat)ARC4RANDOM_MAX;
    CGFloat blue  = (CGFloat)arc4random()/(CGFloat)ARC4RANDOM_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
