//
//  AFN_HS.h
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
//封装在 HS 工作时期所用的网络请求

#define IS_PRINT_LOG YES

@interface AFN_HS : NSObject

/**
 网络请求响应代码块
 
 @param success     请求成功
 @param resultDic   请求结果
 @param errorMsg    请求失败描述
 */
typedef void(^HSResultBlock) (BOOL success, NSDictionary *resultDic, NSString *errorMsg);

/**
 post请求
 
 @param url         请求地址
 @param params      请求参数
 @param resultBlock 响应代码块
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params resultBlock:(HSResultBlock)resultBlock;

@end
