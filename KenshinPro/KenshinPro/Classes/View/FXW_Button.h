//
//  UIButtonK.h
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    纯色按钮，响应的事件通过代码块的回调实现
    可以设置按钮两种状态下的背景色 normal 和 hightLight
 
 */

#import <UIKit/UIKit.h>



@interface FXW_Button : UIButton

typedef void (^FXW_ButtonBlock)(FXW_Button *button);


/**
 点击事件回调

 @param block FXW_ButtonBlock
 */
- (void)clickButtonWithResultBlock:(FXW_ButtonBlock)block;



@end
