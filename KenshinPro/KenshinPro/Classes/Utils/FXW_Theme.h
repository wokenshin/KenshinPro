//
//  FXW_Theme.h
//  KenshinPro
//
//  Created by kenshin on 17/5/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 需要将主题资源添加到项目的根路径下 本项目中添加的 文件名 叫  skin 注意 它必须是蓝色文件夹
 
 注意：放主题的文件夹必须是【蓝色】的，不然编译的时候会报错 提示 文件重名冲突
 原因：【蓝色】文件夹不参与编译，所以不会出现文件冲突，在蓝色文件夹里  imageNamed  加载的是 全部路径，
       如果不是蓝色文件夹的话 会参与编译 imageNamed会直接去找这个文件名 就发现重名冲突了
 数据：
 将颜色值保存到plist
 将图片保存到对应的主题文件夹下 不同主题文件夹下的图片名字保持一致 取图片的时候就根据 主题文件夹来区分
 
 设置UI
 
 
 */
@interface FXW_Theme : NSObject

/**
 设置主题的色调

 @param themeColor 颜色字符串 其实是工程文件夹的名字
 */
+ (void)setThemeColor:(NSString *)themeColor;


/**
 从主题中获取图片 从对应的主题文件夹获取图片

 @param imgName 图片名字
 @return 图片对象
 */
+ (UIImage *)imgWithName:(NSString *)imgName;

/**
 设置Label的字体颜色 从属性列表中获取背景色 从对应的主题文件夹获取颜色

 @return 颜色
 */
+ (UIColor *)colorLabelText;



@end
