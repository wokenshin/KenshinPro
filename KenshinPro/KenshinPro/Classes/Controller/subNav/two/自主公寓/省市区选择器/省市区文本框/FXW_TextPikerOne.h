//
//  FXW_TextGender.h
//  KenshinPro
//
//  Created by kenshin on 2017/8/3.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_TextPikerOne : UITextField




/**
 唯一初始化方法[如果要用xib实现的话 目前无法实现，可以在 awakeFromNib方法中写死数组即可]
 @param frame frame
 @param data 选择的字符串数组 如 @[@"男", @"女"];
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

@end
