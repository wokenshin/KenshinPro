//
//  AFN_MC.h
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

//封装在 MC 工作时期所用的网络请求

#define IS_DEBUG YES  //正式库 NO  测试库 YES

#define signKey @"ldk@api"
#define requestTimeout 20
#define AFN_MC_PLATFORM @"4" //司机端是4  用户端是1
#define AFN_MC_VERSION @"1"
#define AFN_MC_SYSTEM  @"ios"

#define baseUrl IS_DEBUG ? @"http://119.23.130.129:8080/request/post" : @"http://119.23.130.129:8080/request/post"
#define baseUrlMix @"http://119.23.130.129:8080/request/mixed"

/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certRoot @"rootCer.cer"

@interface AFN_MC : NSObject

/**
 MC网络请求代码块
 
 @param success     是否成功
 @param resultDic   返回结果
 @param errorMsg    错误信息 当success == NO时
 */
typedef void(^MCResultBlock) (BOOL success, NSDictionary *resultDic, NSString *errorMsg);

/**
 向哥原来的接口方式，kenshin封装的
 
 @param method 接口的方法名
 @param module 接口的模块名
 @param parms  接口所需的参数
 @param resultblock upload
 */
+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)parms
           resultBlock:(MCResultBlock )resultblock;

/**
 多图上传 单张的时候为单图上传 [表单上传方式]
 
 @param method      接口的方法名
 @param module      接口的模块名
 @param params      接口所需的参数
 @param fileNames   上传本地文件的文件名数组[根据文件名找到文件]
 @param resultblock WSResultBlock
 */
+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)params
        andUploadFiles:(NSArray *)fileNames
           resultBlock:(MCResultBlock )resultblock;

@end
