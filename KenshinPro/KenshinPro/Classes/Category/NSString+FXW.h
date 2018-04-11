//
//  NSString+FXW.h
//  KenshinPro
//
//  Created by kenshin on 2017/8/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 功能列表
 
 1.字符串MD5加密
 2.将16进制字符串转成16进制数据-->fxw_hexStrToData
 3.生成指定长度的随机数字符串 最长9位
 4.URL编码/解码
 
 */
@interface NSString (FXW)


/**
 判断字符串是否为纯正整数字

 @param str 字符串
 @return BOOL
 */
- (BOOL)fxw_isPuerNum:(NSString *)str;

- (NSString *) fxw_md5;

/**
 16进制字符串转16进制数据 NSData就是16进制数据

 @return NSData
 */
- (NSData *)fxw_hexStrToData;


/**
 生成指定长度的随机数数字字符串

 @param len 随机数长度 范围在[1,9] 貌似最长是9
 @return 随机数字符串
 */
+ (NSString *)fxw_randomNumberWithLength:(NSInteger )len;


/**
 URLencode编码

 @return 编码字符串
 */
- (NSString *)fxw_URLEncodedString;

/**
 URLencode解码

 @return 解码字符串
 */
-(NSString *)fxw_URLDecodedString;


/**
 清空字符串中的空格

 @return 字符串
 */
- (NSString *)fxw_cleanSpace;

@end
