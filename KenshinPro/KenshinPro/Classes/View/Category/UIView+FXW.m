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
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}


@end
