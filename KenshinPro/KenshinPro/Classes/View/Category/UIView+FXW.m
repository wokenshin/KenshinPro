//
//  UIView+FXW.m
//  KenshinPro
//
//  Created by kenshin on 17/4/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "UIView+FXW.h"

@implementation UIView (FXW)

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;   //默认是NO,超出主层边界的内容统统剪掉
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}


@end
