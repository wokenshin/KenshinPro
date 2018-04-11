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
    //NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];
    
    NSString *strUrl = @"http://119.23.129.169:8080/request/upload";
    
    //NSDictionary *headers = @{@"sign": sign};
    NSDictionary *parameters = @{@"json":jsonString};
    
    if(AFN_FXW_IS_PRINT_LOG)
    {
        NSLog(@"request==>url=%@", strUrl);
        NSLog(@"request==>json=%@", jsonString);
        //NSLog(@"request==>sign=%@", sign);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"multipartform-data", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:strUrl headers:nil parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //多图上传
        for (NSString * fileName in fileNames)
        {
            NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *filePath      = [documentsPath stringByAppendingPathComponent:fileName];
            NSURL    *fileURL       = [NSURL fileURLWithPath:filePath];
            
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
        NSString     *errorMsg  = [errorInfo objectForKey:@"NSLocalizedDescription"];
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
    if (responseObject == nil || [responseObject isEqual:[NSNull null]]) {
        return @"响应数据为空";
    }
    
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    NSData       *jsonData = [NSJSONSerialization dataWithJSONObject:dictData
                                                             options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr      = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}

//参考 https://www.jianshu.com/p/68a3c916b372
#pragma mark 下载文件
+ (void)postDownloadFileWithUrl:(NSString *)urlStr resultBlock:(FXWResultBlock )resultblock
{
    //判断url地址的合法性 最好是使用正则表达式
    if ([urlStr isEqual:[NSNull null]]
        || urlStr == nil
        || [urlStr isEqualToString:@""]
        || ![urlStr hasPrefix:@"http"])
    {
        resultblock(NO, nil, @"请求地址错误");
        return;
    }
    
    //1,创建会话管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2,创建请求对象
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination--(downloadTask-)
     在该block中告诉AFN应该把文件存放在什么位置,AFN内部会自动的完成文件的剪切处理
     targetPath:文件的临时存储路径(tmp)
     response:响应头信息
     返回值:文件的最终存储路径
     第四个参数:completionHandler 完成之后的回调
     filePath:文件路径 == 返回值
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:
                                          ^(NSProgress * _Nonnull downloadProgress) {
                                              
                                              //进度回调,可在此监听下载进度(已经下载的大小/文件总大小)
                                              NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                              
                                          } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                              
                                              //获取缓存路径 - 大量的文件的话 建议创建 新的文件路径 保存到自己创建的路径下方便管理
                                              NSString *pathCache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                              NSString *fullPath  = [NSString stringWithFormat:@"%@/test.jpg", pathCache];
                                              
                                              NSLog(@"targetPath:%@",targetPath);
                                              NSLog(@"fullPath:%@",fullPath);
                                              
                                              return [NSURL fileURLWithPath:fullPath];
                                              
                                          } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath,
                                                                NSError * _Nullable error) {
                                              
                                              NSLog(@"filePath:%@",filePath);
                                              
                                          }];
    
    [download resume];
    
}





































@end
