//
//  NoDataView.h
//  Mother-Service-Station
//
//  Created by kenshin on 16/7/19.
//  Copyright © 2016年 ddsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView

//当网络请求没有数据时 可以用下面的方法返回一个view作为无数据提示

//设置图片和文本 整个view
+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andContent:(NSString *)content;

//设置图片和文本 和显示的view的高度
+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andContent:(NSString *)content andHeight:(CGFloat)height;

//设置图片 和显示的view的高度
+ (UIView *)tipsNoDataViewWithImgName:(NSString *)imgName andHeight:(CGFloat)height;

@end
