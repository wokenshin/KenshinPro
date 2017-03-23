//
//  UIButtonK.h
//  GYBase
//
//  Created by doit on 16/4/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//
/*
    UIControl 完全可以代替 UIButton 并且 UIControl 中还可以添加视图 所以它用起来会比UIButton 更方便 好用.
    
    本类为自己封装的UIControl
 
    功能描述:
    1.可以通过代码块的回调 设置触发的事件内容
    2.可以直接通过图片名称 设置背景图片 和 高亮背景图片，如果传入的名称有无 将显示默认图片。
    3.UI圆角
 */
#import <UIKit/UIKit.h>

@interface FXW_Control : UIControl


//定义一个代码块 类型 叫 clickControl
typedef void (^FXW_ControlBlock)(FXW_Control *control);


/**
 点击事件回调
 
 @param block FXW_ControlBlock
 */
- (void)clickControlWithResultBlock:(FXW_ControlBlock)block;


@end























