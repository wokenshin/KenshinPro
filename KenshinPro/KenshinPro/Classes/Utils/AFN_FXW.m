//
//  AFN_FXW.m
//  KenshinPro
//
//  Created by kenshin on 17/4/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFN_FXW.h"
#import "AFNetworking.h"
#import "Tools.h"

@implementation AFN_FXW

+ (void)postUploadImageWithFiles:(NSArray *)fileNames resultBlock:(FXWResultBlock )resultblock
{
    //封装请求参数
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setObject:@"upload" forKey:@"module"];
    
    NSError *error= nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&error];
    
    //请求体
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    //加密签名
    //    NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];
    
    NSString *strUrl = @"http://119.23.129.169:8080/request/upload";
    
    //    NSDictionary *headers = @{@"sign": sign};
    NSDictionary *parameters = @{@"json":jsonString};
    
    if(AFN_FXW_IS_PRINT_LOG)
    {
        NSLog(@"request==>url=%@", strUrl);
        NSLog(@"request==>json=%@", jsonString);
        //        NSLog(@"request==>sign=%@", sign);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipartform-data", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:strUrl headers:nil parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //多图上传
        for (NSString * fileName in fileNames)
        {
            NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            
            NSError *error = nil;
            [formData appendPartWithFileURL:fileURL name:@"files" error:&error];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions
                                                                   error:nil];
        
        NSLog(@">>>服务器响应: %@", [AFN_FXW supportChineseWithJson:responseObject]);
        
        if (![Tools isKongWithObj:dictData])
        {
            resultblock(YES, dictData, nil);
        }
        else
        {
            resultblock(NO, nil, @"请求成功，但是返回的参数为空");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary *errorInfo = error.userInfo;
        NSString *errorMsg = [errorInfo objectForKey:@"NSLocalizedDescription"];
        if (errorMsg)
        {
            resultblock(NO, nil, errorMsg);
        }
        else
        {
            resultblock(NO, nil, @"网络请求失败");
        }
        
    }];
    [dataTask resume];
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

@end
