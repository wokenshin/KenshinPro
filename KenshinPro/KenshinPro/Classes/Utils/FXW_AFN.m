//
//  HttpsManagerFXW.m
//  Sanhe
//
//  Created by kenshin on 16/11/21.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "FXW_AFN.h"
#import "AFNetworking.h"
#import "NSString+Utils.h"
#import "FXWUD.h"
#import "Tools.h"

@implementation FXW_AFN


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
    NSString *sign = [FXW_AFN jiaMiSignWithData:bodyData andVersion:appVersion];//加密签名
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [req setValue:@"iphone_ldkd_driver" forHTTPHeaderField:@"User-Agent"];
//    [req setValue:[FXWUD userToken] forHTTPHeaderField:@"user-token"];
    [req setValue:@"CN" forHTTPHeaderField:@"accept-language"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:bodyData];//将请求添加到http body
    [req addValue:sign forHTTPHeaderField:@"sign"];
    
    NSLog(@"————————————————————————————网络请求 POST——————————————————————————————————————");
    NSLog(@">>> url: %@",  url);
    NSLog(@">>> json: %@", params);
    
    
    //新的API
    [[manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            NSLog(@">>> 请求成功");
//            NSLog(@">>>message: %@", [dictData objectForKey:@"message"]);
            NSLog(@">>>respone: %@", [FXW_AFN supportChineseWithJson:responseObject]);
            success(responseObject);
        }
        else
        {
            NSLog(@">>> 请求失败: error%@", error);
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
    NSLog(@"————————————————————————————网络请求 GET——————————————————————————————————————");
    NSLog(@">>> url: %@",  url);
    NSLog(@">>> json: %@", params);

    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置AFN 忽略缓存 不然这个地方获取的不会是最新数据
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    //证书配置【这里支持多证书, 添加到pathCers中即可】
    NSArray *pathCers = [FXW_AFN patchCerInBundleWithNames:@[certRoot]];
    [FXW_AFN setCertificateForHTTPSWithcertificatePathByArray:pathCers andManager:manager];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@">>> 请求成功");
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@">>> 请求失败 error:%@",error);
        
    }];

}

#pragma mark 设置证书
+ (void)setCer:(AFHTTPSessionManager *)manager
{
    //证书配置【这里支持多证书, 添加到pathCers中即可】
    //采用多证书验证的方式 的使用场景是这样的：比如当我们访问了多个不同的服务器 而这些服务器又分别用了不同的安全证书，所以需要以此对证书进行验证
    NSArray *pathCers = [FXW_AFN patchCerInBundleWithNames:@[certRoot]];
    [FXW_AFN setCertificateForHTTPSWithcertificatePathByArray:pathCers andManager:manager];
    
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
        for (NSString *Path in cerPaths) {
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
+ (NSString *)jiaMiSignWithData:(NSData *)bodyData andVersion:(int)version
{
    //加密信息  MD5One = MD5(秘钥信息+接口版本号)==>转成小写
    //再次加密  MD5(请求参数信息+MD5One)==>转成小写
    NSString *plaintext = [NSString stringWithFormat:@"%@%d", signKey, version];
    plaintext = [plaintext md5].lowercaseString;
    
    //请求参数信息【请求体】
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    plaintext = [NSString stringWithFormat:@"%@%@",jsonString, plaintext];
    NSString *sign = [plaintext md5].lowercaseString;
    return sign;
    
}


+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)parms
           resultBlock:(WSResultBlock )resultblock
{
    
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setObject:method    forKey:@"method"];
    [requestDic setObject:module    forKey:@"module"];
    [requestDic setObject:@"ios"    forKey:@"os"];
    [requestDic setObject:@"4"      forKey:@"platform"];
    [requestDic setObject:[FXWUD userToken] forKey:@"token"];
    [requestDic setObject:@"1"      forKey:@"version"];
    
    [requestDic setObject:parms     forKey:@"parms"];
    
    [FXW_AFN post:baseUrl params:requestDic success:^(id responseObj) {
                    
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                             options:kNilOptions
                                                                               error:nil];
        NSDictionary *result = [dictData objectForKey:@"result"];
        NSDictionary *error = [dictData objectForKey:@"error"];
        
        if (![Tools isKongWithObj:result])
        {
            resultblock(YES, dictData);
        }
        else if(![Tools isKongWithObj:error])
        {
            NSString *msg = [error objectForKey:@"message"];
            NSLog(@"网络请求出错: %@", msg);
            resultblock(NO, dictData);
        }
        else
        {
            resultblock(NO, dictData);
        }
        
    }
    failure:^(NSError *error) {
                    
          resultblock(NO, nil);
    
    }];

}

//上传图片
+ (void)postWithMethod:(NSString *)method
                module:(NSString *)module
                params:(NSDictionary *)params
         andUploadFiles:(NSArray *)fileNames
           resultBlock:(WSResultBlock )resultblock
{
    
    NSMutableDictionary *requestDic = [[NSMutableDictionary alloc] init];
    [requestDic setObject:method    forKey:@"method"];
    [requestDic setObject:module    forKey:@"module"];
    [requestDic setObject:params     forKey:@"parms"];
    
    [requestDic setObject:@"ios"    forKey:@"os"];
    [requestDic setObject:@"4"      forKey:@"platform"];
    [requestDic setObject:[FXWUD userToken] forKey:@"token"];
    [requestDic setObject:@"1"      forKey:@"version"];
    
    NSError *error= nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&error];
    
    //请求体
    NSString *jsonString = [[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding];
    
    //加密签名
    NSString *sign = [FXW_AFN jiaMiSignWithData:bodyData andVersion:appVersion];
    
    NSString *strUrl = baseUrlMix;
    
    NSDictionary *headers = @{@"sign": sign};
    NSDictionary *parameters = @{@"json":jsonString};
    
    if(IS_DEBUG){
        NSLog(@"request==>url=%@", strUrl);
        NSLog(@"request==>json=%@", jsonString);
        NSLog(@"request==>sign=%@", sign);
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:strUrl headers:headers parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //多图上传
        for (NSString * fileName in fileNames) {
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
        
        NSLog(@">>> 请求成功");
        NSLog(@">>>respone: %@", [FXW_AFN supportChineseWithJson:responseObject]);
        
        if (![Tools isKongWithObj:result])
        {
            resultblock(YES, dictData);
        }
        else if(![Tools isKongWithObj:error])
        {
            resultblock(NO, dictData);
        }
        else
        {
            resultblock(NO, dictData);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        resultblock(NO, nil);
        
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

