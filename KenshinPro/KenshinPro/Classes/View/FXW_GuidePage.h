//
//  FXW_GuidePage.h
//  KenshinPro
//
//  Created by kenshin on 2017/9/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_GuidePage : UIView



/**
 显示引导页

 @param imgNames          引导页图片名称数组
 @param colorNormal       分页栏默认按钮
 @param colorSelected     分页栏选中按钮
 @param finishBtnTitle    完成按钮标题
 */
+ (BOOL)fxw_showGuidePageWithImgNames:(NSArray *)imgNames
               pageControlColorNormal:(UIColor *)colorNormal
             pageControlColorSelected:(UIColor *)colorSelected
                       finishBtnTitle:(NSString *)finishBtnTitle;



@end
