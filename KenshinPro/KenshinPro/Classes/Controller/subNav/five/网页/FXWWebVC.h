//
//  FXWWebVC.h
//  KenshinPro
//
//  Created by apple on 2018/8/8.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 功能概括
 1.加载网页
 2.加载本地网页
 3.显示菊花
 4.可返回到网页中的上一页
 
 [未]5.cookie
 [未]6.js交互——可参考原来的demo
 */
@interface FXWWebVC : UIViewController



/**
 加载远端网页

 @param url 网页地址
 */
- (void)loadUrl:(NSString *)url;


/**
 加载本地网页

 @param content 本地网页内容
 */
- (void)loadLocalContent:(NSString *)content;

@end
