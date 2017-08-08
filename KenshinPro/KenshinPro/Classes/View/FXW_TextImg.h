//
//  FXW_TextImg.h
//  KenshinPro
//
//  Created by kenshin on 2017/8/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_TextImg : UITextField

typedef void (^FXW_TextImgBlock)(FXW_TextImg *control);


/**
 设置文本框左边图片,设置图片后可以监听图片的点击事件

 @param leftView 图片
 */
- (void)fxw_setLeftImgView:(UIImageView *)leftView;

/**
 监听左视图点击事件

 @param resultBlock FXW_TextImgBlock
 */
- (void)fxw_clickLeftImg:(FXW_TextImgBlock)resultBlock;

/**
 设置文本框右边图片,设置图片后可以监听图片的点击事件
 
 @param leftView 图片
 */
- (void)fxw_setRightImgView:(UIImageView *)leftView;

/**
 监听右视图点击事件
 
 @param resultBlock FXW_TextImgBlock
 */
- (void)fxw_clickRightImg:(FXW_TextImgBlock)resultBlock;
@end
