//
//  NSData+FXW.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSData+FXW.h"
#import <CommonCrypto/CommonDigest.h>//md5

@implementation NSData (FXW)

-(int32_t)crc32
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

- (NSString *)md5
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


@end
