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

- (void)fxw_addBorder:(FXWBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    switch (direction)
    {
        case FXWBorderDirectionTop:
        {
            border.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, width);
        }
            break;
        case FXWBorderDirectionLeft:
        {
            border.frame = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height);
        }
            break;
        case FXWBorderDirectionBottom:
        {
            border.frame = CGRectMake(0.0f, self.bounds.size.height - width, self.bounds.size.width, width);
        }
            break;
        case FXWBorderDirectionRight:
        {
            border.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        }
            break;
        default:
            break;
    }
    [self.layer addSublayer:border];
    
}

@end
