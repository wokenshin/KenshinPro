//
//  NSData+FXW.h
//  KenshinPro
//
//  Created by kenshin on 2017/8/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 功能列表
 
 1.将16进制数据转成16进制字符串-->fxw_hexStrToData
 2.CRC32校验
 3.md5加密
 
 */
@interface NSData (FXW)

/**
 将NSData转成16进制字符串

 @return NSString
 */
- (NSString *)fxw_toHexStr;


/**
 CRC32校验

 @return int32_t
 */
-(int32_t) fxw_crc32;

/**
 MD5加密

 @return 加密后的字符串
 */
- (NSString *)fxw_md5;

@end
