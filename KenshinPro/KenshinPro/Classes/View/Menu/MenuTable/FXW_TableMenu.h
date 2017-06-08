//
//  FXW_TableMenu.h
//  CleverApartment
//
//  Created by kenshin on 2017/6/8.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXW_TableMenu : UIView


/**
 这是一个高度根据数组长度 <=1/2 屏幕高度 的 菜单view
 初始化对象之后 会立即在窗口显示该视图，点击蒙版 视图消除释放自身

 @param title   标题
 @param array   字符串输入
 @return        菜单视图
 */
+ (instancetype)fxwWithTitle:(NSString *)title array:(NSArray *)array;


typedef void (^FXW_TableMenuBlock)(NSInteger index);


/**
 当点击菜单中的cell时会触发这里的block

 @param block 返回数据源的索引
 */
- (void)clickCellWithResultblock:(FXW_TableMenuBlock)block;

@end
