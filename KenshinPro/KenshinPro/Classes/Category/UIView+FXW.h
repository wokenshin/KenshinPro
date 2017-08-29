//
//  UIView+FXW.h
//  KenshinPro
//
//  Created by kenshin on 17/4/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 定义设置边框的方向枚举

 - FXWBorderDirectionTop:       上
 - FXWBorderDirectionLeft:      左
 - FXWBorderDirectionBottom:    下
 - FXWBorderDirectionRight:     右
 */
typedef NS_ENUM(NSInteger, FXWBorderDirectionType) {
    FXWBorderDirectionTop = 0,
    FXWBorderDirectionLeft,
    FXWBorderDirectionBottom,
    FXWBorderDirectionRight
};
@interface UIView (FXW)


/**
 参考：http://www.jianshu.com/p/055c9982778f
 功能：使用该分类可以在xib or sb 中直接设置UI的圆角 选中UI后在属性指示器中能找到cornerRadius的属性就可以设置圆角了
 
 在.m文件中实现了设置圆角的代码
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;



/**
 向指定边添加边框

 @param direction 方向
 @param color 颜色
 @param width 宽度
 */
- (void)fxw_addBorder:(FXWBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width;


@end
