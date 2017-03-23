//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FXW_TextView : UITextView

@property(copy,nonatomic)   NSString    *placeholder;
@property(strong,nonatomic) UIColor     *placeholderColor;
@property(strong,nonatomic) UIFont      *placeholderFont;



//定义一个代码块类型
typedef void (^FXW_TextViewBlock)(FXW_TextView *textView);

/**
 设置文本长度
 
 @param len 文本长度
 @param block 当输入内容超过设置长度时触发的回调[超出设置长度后的内容不会被赋值到UI上]
 */
- (void)setLimitLen:(NSInteger)len andWithResultBlock:(FXW_TextViewBlock)block;


/**
 文本每编辑一次字符就会触发一次
 
 @param block 回调
 */
- (void)textEditingWithResultBlock:(FXW_TextViewBlock)block;

@end

