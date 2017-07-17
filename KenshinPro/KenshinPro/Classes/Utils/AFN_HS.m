//
//  AFN_HS.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFN_HS.h"
#import "AFNetworking.h"

static NSString *userTokenTmp = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MDc4MDEzMTcsImlhdCI6MTQ5OTg1MjUxNywiaXNzIjoiYXBwLm0ybWtleS5jb20iLCJzdWIiOiI1OTY1YzNjYjY1NTk4YjQxMWM3NDAzYjIifQ.djghcPR1pEKxjEPThqwiFYyPGu6mamIzXSx0_v7qDWs";

static NSString *apiKey = @"userTokenTmp";

@implementation AFN_HS

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params resultBlock:(HSResultBlock)resultBlock
{
    NSError *error = nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    //设置响应格式为data
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //添加证书 注意只有自签名证书或者免费证书才需要设置【如果是付费证书可以不用做任何设置】
    //[FXWAFNManager setCer:manager];
    
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                             URLString:url
                                                                            parameters:nil
                                                                                 error:nil];
    //设置请求超时时间
    req.timeoutInterval= 20;
    
    [AFN_HS setHeaderInfo:req];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:bodyData];//将请求添加到http body
    
    
    if (IS_PRINT_LOG)
    {
        NSLog(@"————————————————————————————网络请求 POST——————————————————————————————————————");
        NSLog(@">>> url: %@",  url);
        NSLog(@">>> post请求: %@", [AFN_HS supportChineseWithDic:params]);
    }
    
    [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error)
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>>服务器响应: %@", [AFN_HS supportChineseWithJson:responseObject]);
            }
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            resultBlock(YES, dictData, nil);
        }
        else
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>> 请求失败: error%@", error);
            }
            
            NSDictionary *errorInfo = error.userInfo;
            NSString *errorMsg = [errorInfo objectForKey:@"NSLocalizedDescription"];
            if (errorMsg)
            {
                resultBlock(NO, nil, errorMsg);
            }
            else
            {
                resultBlock(NO, nil, @"网络请求失败");
            }
            
        }
    }] resume];
    
}

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params resultBlock:(HSResultBlock)resultBlock
{
    NSError *error = nil;
    
    NSData *bodyData = nil;
    
    if (params != nil)
    {
        bodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    //设置响应格式为data
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET"
                                                                             URLString:url
                                                                            parameters:nil
                                                                                 error:nil];
    //设置请求超时时间
    req.timeoutInterval= 20;
    
    //设置http表头
    //    NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];//加密签名
    
    [AFN_HS setHeaderInfo:req];
    
    [req setHTTPMethod:@"GET"];
    
    if (bodyData != nil)
    {
        [req setHTTPBody:bodyData];//将请求添加到http body
    }
    
    if (IS_PRINT_LOG)
    {
        NSLog(@"————————————————————————————网络请求 GET——————————————————————————————————————");
        NSLog(@">>> url: %@",  url);
        NSLog(@">>> get请求: %@", [AFN_HS supportChineseWithDic:params]);
    }
    
    [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error)
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>>服务器响应: %@", [AFN_HS supportChineseWithJson:responseObject]);
            }
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            resultBlock(YES, dictData, nil);
        }
        else
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>> 请求失败: error%@", error);
            }
            
            NSDictionary *errorInfo = error.userInfo;
            NSString *errorMsg = [errorInfo objectForKey:@"NSLocalizedDescription"];
            if (errorMsg)
            {
                resultBlock(NO, nil, errorMsg);
            }
            else
            {
                resultBlock(NO, nil, @"网络请求失败");
            }
            
        }
    }] resume];
    
}

#pragma mark - 设置请求头部信息
+ (void)setHeaderInfo:(NSMutableURLRequest *)req
{
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"CN" forHTTPHeaderField:@"accept-language"];
    
    [req setValue:apiKey forHTTPHeaderField:@"API-Key"];
    [req setValue:@"" forHTTPHeaderField:@"Timestamp"];
    [req addValue:userTokenTmp forHTTPHeaderField:@"Authorization"];
    
}

/**
 将服务器返回的json数据转换格式 返回支持输出的中文字符串
 
 @param responseObject 响应数据
 @return 字符串
 */
+ (NSString *)supportChineseWithJson:(id)responseObject
{
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictData
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    // NSData转为NSString
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}

//输出中文
+ (NSString *)supportChineseWithDic:(NSDictionary *)dic
{
    if (dic == nil || [dic isEqual:[NSNull null]])
    {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    // NSData转为NSString
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}


@end
