//
//  YinDaoVC.h
//  KenshinPro
//
//  Created by kenshin on 2017/9/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

@interface YinDaoVC : BaseVC


/**
 初始化引导页数据及分页按钮颜色

 @param imgNames            图片名称数组
 @param colorNormal         分页选项UI默认颜色
 @param colorSelected       分页选项UI选中时颜色
 */
- (BOOL)initGuidePageWithImgNames:(NSArray *)imgNames
           pageControlColorNormal:(UIColor *)colorNormal
         pageControlColorSelected:(UIColor *)colorSelected
                   finishBtnTitle:(NSString *)finishBtnTitle;

@end
