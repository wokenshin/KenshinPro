//
//  NSData+FXW.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSData+FXW.h"
#import <CommonCrypto/CommonDigest.h>//md5

@implementation NSData (FXW)

#pragma mark crc32
-(int32_t)fxw_crc32
{
    uint32_t *table = malloc(sizeof(uint32_t) * 256);
    uint32_t crc = 0xffffffff;
    uint8_t *bytes = (uint8_t *)[self bytes];
    
    for (uint32_t i=0; i<256; i++)
    {
        table[i] = i;
        for (int j=0; j<8; j++)
        {
            if (table[i] & 1)
            {
                table[i] = (table[i] >>= 1) ^ 0xedb88320;
            }
            else
            {
                table[i] >>= 1;
            }
        }
    }
    
    for (int i=0; i<self.length; i++)
    {
        crc = (crc >> 8) ^ table[(crc & 0xff) ^ bytes[i]];
    }
    crc ^= 0xffffffff;
    
    free(table);
    return crc;
    
}

#pragma mark md5加密
- (NSString *)fxw_md5
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
    
}

- (NSString *)fxw_toHexStr
{
    if (!self || [self length] == 0)
    {
        return @"";
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[self length]];
    
    [self enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop)
     {
         unsigned char *dataBytes = (unsigned char*)bytes;
         for (NSInteger i = 0; i < byteRange.length; i++)
         {
             NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
             if ([hexStr length] == 2)
             {
                 [string appendString:hexStr];
             }
             else
             {
                 [string appendFormat:@"0%@", hexStr];
             }
         }
     }];
    
    return string;

    
}

@end
