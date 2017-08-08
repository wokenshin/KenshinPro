//
//  FXW_AptBtn.h
//  AptLandlord
//
//  Created by kenshin on 2017/7/28.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_AptBtn : UIView


/**
 唯一初始化方法

 @param frame       frame width = 140 height = 50 这两个参数值写死
 @param title       按钮名字
 @param imgName     图片名字
 @return            FXW_AptBtn实例
 */
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName;


typedef void (^FXW_AptBtnBlock)(FXW_AptBtn *cuObj);


- (void)click:(FXW_AptBtnBlock)block;

@end
