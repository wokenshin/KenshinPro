//
//  HttpsManagerFXW.h
//  Sanhe
//
//  Created by kenshin on 16/11/21.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//
#import <Foundation/Foundation.h>


/*
 这里放最基础的对AFN的封装，然后再单独弄一个类来进行更好的封装
 例如 mqds的 就弄一个类来封装mqds的， ddzm的 就弄一个类来封装ddzm的
 
 类名叫 MQDS_AFN           DDZM_AFN or  HSGX_AFN 有空的时候搞
 
 */


#define IS_DEBUG YES  //正式库 NO  测试库 YES

//mqds 的 网络请求封装
#define signKey @"签名字符串"
#define requestTimeout 20
#define appPlatform 4
#define appVersion 1


#define baseUrl IS_DEBUG ? @"http://111.111.111.111:8080/" : @"https://www.baidu.com"
#define baseUrlMix @"http://111.111.111.111:8080/mixed"


/**
 *  是否开启https SSL 验证
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO //暂时没用到这个宏
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certRoot @"rootCer.cer"


@interface FXW_AFN : NSObject

/**
 *  发送一个POST请求 请求数据是放在body里面的
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure;

+ (void)get:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure;


/**
 POST请求返回的block

 @param success     网络请求成功
 @param resultDic   返回的数据字典
 */
typedef void(^WSResultBlock) (BOOL success, NSDictionary *resultDic);

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
           resultBlock:(WSResultBlock )resultblock;


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
           resultBlock:(WSResultBlock )resultblock;


@end
