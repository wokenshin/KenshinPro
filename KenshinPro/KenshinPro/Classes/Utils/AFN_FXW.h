//
//  AFN_FXW.h
//  KenshinPro
//
//  Created by kenshin on 17/4/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFN_FXW : NSObject

#define AFN_FXW_IS_PRINT_LOG YES//是否输出网络请求日志


/**
 FXW网络请求代码块
 
 @param success     是否成功
 @param resultDic   返回结果
 @param errorMsg    错误信息 当success == NO时
 */
typedef void(^FXWResultBlock) (BOOL success, NSDictionary *resultDic, NSString *errorMsg);


/**
 上传图片 表单上传方式 支持多图上传

 @param fileNames 图片数组
 @param resultblock 响应Block
 */
+ (void)postUploadImageWithFiles:(NSArray *)fileNames resultBlock:(FXWResultBlock )resultblock;

//还有一种上传图片的方式是 base64， 就是把图片转成字符串，直接放到请求的参数里面 hb的项目里面有实现

@end
