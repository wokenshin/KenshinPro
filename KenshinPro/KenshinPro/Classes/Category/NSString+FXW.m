//
//  NSString+FXW.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSString+FXW.h"
#import <CommonCrypto/CommonDigest.h>//MD5

@implementation NSString (FXW)

- (BOOL)fxw_isPuerNum:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
    
}

- (NSString *) fxw_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSData *)fxw_hexStrToData
{
    //注意一定要是16进制字符串，必须是2的整数倍长度 不然计算出来的结果会高位补零 字符串中不要有空格
    if (!self || [self length] == 0)
    {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    
    if ([self length] % 2 == 0)
    {
        range = NSMakeRange(0, 2);
    }
    else
    {
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < [self length]; i += 2)
    {
        unsigned int anInt;
        NSString *hexCharStr = [self substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;

}

+ (NSString *)fxw_randomNumberWithLength:(NSInteger )len
{
    //参考:http://www.cnblogs.com/xiaohuzi1990/p/4387040.html?utm_source=tuicool&utm_medium=referral
    
    int ran     = arc4random();//拿到随机数
    int ranAbs  = abs(ran);//取绝对值
    int nonce   = ranAbs % (int)pow(10, len);//取最后的len位
    NSString *tmpNonce = [NSString stringWithFormat:@"%08zd",nonce];//高位不足补零
    
    return tmpNonce;
    
}

/**
 *  url字符串中具有特殊功能的特殊字符的字符串，或者中文字符,作为参数用GET方式传递时，需要用urlencode处理一下。
 *
 *  例如：在 iOS 程序访问 HTTP 资源时，像拼出来的 http://unmi.cc?p1=%+&sd f&p2=中文，其中的中文、特殊符号&％和空格都必须进行转译才能正确访问。
 */
- (NSString *)fxw_URLEncodedString
{
    //参考: http://blog.csdn.net/aaidong/article/details/45640859
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}

/**
 *  URLDecode
 */
-(NSString *)fxw_URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
    
}

@end
