//
//  FXW_TextField.h
//  Sanhe
//
//  Created by kenshin on 17/3/14.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_TextField : UITextField

/*功能概述
 
    1.限制文本框输入内容，字符串、数字、小数[未实现]这样应该可以限制输入表情
    2.是否禁止粘贴、禁止输入空           [未实现]
    3.限制文本长度
    4.监听文本框的编辑 当文本内容发生改变时触发回调
    5.设置软键盘的return为搜索按钮 并监听事件
    6.文本框被点击时触发
 
 
 */


//定义一个代码块 类型 叫 clickControl
typedef void (^FXW_TextFieldBlock)(FXW_TextField* text);

//定义一个枚举 限制文本框的输入内容
typedef NS_ENUM(NSInteger, InputValueType)
{
    InputValueTypeNum               = 1,
    InputValueTypeDouble            = 2,
    InputValueTypeString            = 3,//不设置输入类型 默认是字符串
    InputValueTypePassword          = 4,
    
};

/**
 设置文本长度

 @param len 文本长度
 @param block 当输入内容超过设置长度时触发的回调[超出设置长度后的内容不会被赋值到UI上]
 */
- (void)setLimitLen:(NSInteger)len andWithResultBlock:(FXW_TextFieldBlock )block;

/**
 限制文本框的输入类型，限制类型的同时，更改软键盘的显示 数字就显示数字键盘，小数就显示小数键盘等

 @param inputType InputValueType
 */
- (void)setLimitInputValue:(InputValueType)inputType;

/**
 监听文本框的编辑 当文本内容发生改变时触发回调

 @param block 返回文本实例
 */
- (void)textEdittingWithResultBlock:(FXW_TextFieldBlock )block;

/**
 设置软键盘的return为搜索按钮 并监听事件

 @param block 点击软键盘的搜索按钮时触发的回调
 */
- (void)searchingWithResultBlock:(FXW_TextFieldBlock )block;

/**
 文本框被点击时触发

 @param block 文本框被点击时触发
 */
- (void)begainEditWithResultBlock:(FXW_TextFieldBlock )block;



@end
