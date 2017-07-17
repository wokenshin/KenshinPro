//
//  AFN_MC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFN_MC.h"
#import "AFNetworking.h"
#import "NSString+Utils.h"//MD5
#import "Tools.h"

@implementation AFN_MC

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
{
    NSError *error= nil;
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
    req.timeoutInterval= requestTimeout;
    
    //设置http表头
    NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];//加密签名
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"CN" forHTTPHeaderField:@"accept-language"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:bodyData];//将请求添加到http body
    [req addValue:sign forHTTPHeaderField:@"sign"];
    
    if (IS_PRINT_LOG)
    {
        NSLog(@"————————————————————————————网络请求 POST——————————————————————————————————————");
        NSLog(@">>> url: %@",  url);
        NSLog(@">>> post请求: %@", [AFN_MC supportChineseWithDic:params]);
    }
    
    
    //新的API
    [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>>服务器响应: %@", [AFN_MC supportChineseWithJson:responseObject]);
            }
            success(responseObject);
        }
        else
        {
            if (IS_PRINT_LOG)
            {
                NSLog(@">>> 请求失败: error%@", error);
            }
            failure(error);
        }
        
    }] resume];
    
}

#pragma mark get请求  这里的url是 http开头的 不是https
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    if (IS_PRINT_LOG)
    {
        NSLog(@"————————————————————————————网络请求 GET——————————————————————————————————————");
        NSLog(@">>> url: %@",  url);
        NSLog(@">>> json: %@", params);
    }
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置AFN 忽略缓存 不然这个地方获取的不会是最新数据
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    //证书配置【这里支持多证书, 添加到pathCers中即可】
    NSArray *pathCers = [AFN_MC patchCerInBundleWithNames:@[certRoot]];
    [AFN_MC setCertificateForHTTPSWithcertificatePathByArray:pathCers andManager:manager];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
}

#pragma mark 设置证书
+ (void)setCer:(AFHTTPSessionManager *)manager
{
    //证书配置【这里支持多证书, 添加到pathCers中即可】
    //采用多证书验证的方式 的使用场景是这样的：比如当我们访问了多个不同的服务器 而这些服务器又分别用了不同的安全证书，所以需要以此对证书进行验证
    NSArray *pathCers = [AFN_MC patchCerInBundleWithNames:@[certRoot]];
    [AFN_MC setCertificateForHTTPSWithcertificatePathByArray:pathCers andManager:manager];
    
}

//自签名证书
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certRoot ofType:nil];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSMutableSet *mSet = [NSMutableSet setWithObject:certData];
    securityPolicy.pinnedCertificates = mSet;
    
    return securityPolicy;
}

#pragma mark 获取Bundle中的证书路径
+ (NSArray *)patchCerInBundleWithNames:(NSArray *)cerNames
{
    if (cerNames != nil && [cerNames count] > 0)
    {
        NSMutableArray *mArrPathCers = [NSMutableArray array];
        for (int i = 0; i < [cerNames count]; i++)
        {
            NSString *cerName = [cerNames objectAtIndex:i];
            if (cerName != nil && ![cerName isEqualToString:@""])
            {
                NSString *pathCer = [[NSBundle mainBundle]pathForResource:cerName ofType:nil];
                [mArrPathCers addObject:pathCer];
            }
        }
        return mArrPathCers;
    }
    return nil;
}

#pragma mark 配置服务器证书或根证书
+ (void)setCertificateForHTTPSWithcertificatePathByArray:(NSArray *)cerPaths
                                              andManager:(AFHTTPSessionManager *)manager
{
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;      //是否允许使用自签名证书
    securityPolicy.validatesDomainName = NO;           //是否需要验证域名
    
    AFHTTPSessionManager *weakManager = manager;//防止循环引用
    
    /*
     服务端在接收到客户端请求时会有的情况需要验证客户端证书，要求客户端提供合适的证书，再决定是否返回数据。
     这种情况即为质询(challenge)认证,双方进行公钥和私钥的验证。
     为实现客户端验证，manager须设置需要身份验证回调的方法
     */
    //质询
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *_credential) {
        
        /// 获取服务器的trust object
        SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
        
        NSData *caCert = nil;
        
        //        NSMutableArray *dataMCer = [NSMutableArray array];
        for (NSString *Path in cerPaths)
        {
            caCert = [NSData dataWithContentsOfFile:Path];
            //            [dataMCer addObject:caCert];
        }
        
        //        weakManager.securityPolicy.pinnedCertificates = dataMCer;
        
        SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
        NSCAssert(caRef != nil, @"caRef is nil");
        NSArray *caArray = @[(__bridge id)(caRef)];
        NSCAssert(caArray != nil, @"caArray is nil");
        
        // 将读取到的证书设置为serverTrust的根证书
        OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
        SecTrustSetAnchorCertificatesOnly(serverTrust,NO);
        NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
        
        //选择质询认证的处理方式
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        
        //NSURLAuthenticationMethodServerTrust质询认证方式
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        {
            //基于客户端的安全策略来决定是否信任该服务器，不信任则不响应质询。
            if ([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host])
            {
                //创建质询证书
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                //确认质询方式
                if (credential)
                {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
                else
                {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            }
            else
            {
                //取消挑战
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        }
        else
        {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
        
        return disposition;
    }];
}

//加密签名
+ (NSString *)jiaMiSignWithData:(NSData *)bodyData andVersion:(NSString *)version
{
    //加密信息  MD5One = MD5(秘钥信息+接口版本号)==>转成小写
    //再次加密  MD5(请求参数信息+MD5One)==>转成小写
    NSString *plaintext = [NSString stringWithFormat:@"%@%@", signKey, version];
    plaintext = [plaintext md5].lowercaseString;
    
    //请求参数信息【请求体】
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    plaintext = [NSString stringWithFormat:@"%@%@",jsonString, plaintext];
    NSString *sign = [plaintext md5].lowercaseString;
    return sign;
    
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
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    // NSData转为NSString
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}

//返回请求必须的基础参数
+ (NSMutableDictionary *)requestMode
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:AFN_MC_SYSTEM   forKey:@"os"];
    [mDic setObject:AFN_MC_PLATFORM forKey:@"platform"];
    [mDic setObject:@"userToken"    forKey:@"token"];
    [mDic setObject:AFN_MC_VERSION  forKey:@"version"];
    
    return mDic;
    
}

#pragma mark - MC POST
+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)parms
           resultBlock:(MCResultBlock )resultblock
{
    //封装请求参数
    NSMutableDictionary *requestDic = [AFN_MC requestMode];
    [requestDic setObject:method        forKey:@"method"];
    [requestDic setObject:module        forKey:@"module"];
    [requestDic setObject:parms         forKey:@"parms"];
    
    //网络请求
    [AFN_MC post:baseUrl
          params:requestDic
         success:^(id responseObj) {
             
             NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                      options:kNilOptions
                                                                        error:nil];
             NSDictionary *result = [dictData objectForKey:@"result"];
             NSDictionary *error  = [dictData objectForKey:@"error"];
             
             if (result != nil && ![result isEqual:[NSNull null]])
             {
                 resultblock(YES, result, nil);
             }
             else if(error != nil && ![error isEqual:[NSNull null]])
             {
                 NSString *message = [error objectForKey:@"message"];
                 
                 if (message != nil && ![message isEqual:[NSNull null]])
                 {
                     resultblock(NO, nil, message);
                 }
             }
             else
             {
                 resultblock(NO, nil, @"服务器返回异常");
             }
             
         }
         failure:^(NSError *error){
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
    
}

#pragma mark - MC 多图上传 已表单的形式[先将图片保存到本地，然后从本地取出图片进行上传]
//上传图片
+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)params
        andUploadFiles:(NSArray *)fileNames
           resultBlock:(MCResultBlock )resultblock
{
    //封装请求参数
    NSMutableDictionary *requestDic = [AFN_MC requestMode];
    [requestDic setObject:method        forKey:@"method"];
    [requestDic setObject:module        forKey:@"module"];
    [requestDic setObject:params        forKey:@"parms"];
    
    NSError *error= nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&error];
    
    //请求体
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    //加密签名
    NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];
    
    NSString *strUrl = baseUrlMix;
    
    NSDictionary *headers = @{@"sign": sign};
    NSDictionary *parameters = @{@"json":jsonString};
    
    if(IS_PRINT_LOG)
    {
        NSLog(@"request==>url=%@", strUrl);
        NSLog(@"request==>json=%@", jsonString);
        NSLog(@"request==>sign=%@", sign);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:strUrl headers:headers parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
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
        NSDictionary *result = [dictData objectForKey:@"result"];
        NSDictionary *error = [dictData objectForKey:@"error"];
        
        NSLog(@">>>服务器响应: %@", [AFN_MC supportChineseWithJson:responseObject]);
        
        if (![Tools isKongWithObj:result])
        {
            resultblock(YES, result, nil);
        }
        else if(![Tools isKongWithObj:error])
        {
            NSString *message = [error objectForKey:@"message"];
            
            if (message != nil && ![message isEqual:[NSNull null]])
            {
                resultblock(NO, nil, message);
            }
        }
        else
        {
            resultblock(NO, nil, @"服务器异常");
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

//上传图片
+ (void)postUploadImageWithFiles:(NSArray *)fileNames resultBlock:(MCResultBlock )resultblock
{
    //封装请求参数
    /*
     @{@"method":@"updatePicture",@"os":@"iOS",@"module":@"user",@"platform":@"client",@"parms":@{@"phoneNo":@"18159021786"},@"version":@1,@"token":@"5a03145b604eebed30e829d226a34696"}
     */
    NSDictionary *requestDic = @{@"method":@"updatePicture",@"os":@"iOS",@"module":@"user",@"platform":@"client",@"parms":@{@"phoneNo":@""},@"version":@1,@"token":@"5a03145b604eebed30e829d226a34696"};
    
    
    
    
    NSError *error= nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&error];
    
    //请求体
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    //加密签名
//    NSString *sign = [AFN_MC jiaMiSignWithData:bodyData andVersion:AFN_MC_VERSION];
    
    NSString *strUrl = @"http://app.zhonglexiang.com:8080/reportapi/request/mixed";//baseUrlMix;
    
//    NSDictionary *headers = @{@"sign": sign};
    NSDictionary *parameters = @{@"json":jsonString};
    
    if(IS_PRINT_LOG)
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
        
        NSLog(@">>>服务器响应: %@", [AFN_MC supportChineseWithJson:responseObject]);
        
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

























@end
