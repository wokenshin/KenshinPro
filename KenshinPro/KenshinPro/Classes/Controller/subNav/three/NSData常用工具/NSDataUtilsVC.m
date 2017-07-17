//
//  NSDataUtilsVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/7/13.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSDataUtilsVC.h"


/**
 功能:
 1.NSData—>16进制字符串
 2.将16进制字符串—>NSData
 3.获取NSData中某一bit赋值给uint_8
 4.获取NSData中某一段赋值给subData
 5.16进制—>10进制，10进制—>16进制
 6.获取一个bit中的 前一位/后一位 如 ox1a 2b 3c 4d 中的3c 获取其中的3 或者c[有两种方法 转字符串获取 通过与和位运算获取]
 7.C语言高位补0 例如 希望有6位 如果输出是 1234 则变成 001234
 
 */
@interface NSDataUtilsVC ()

@end

@implementation NSDataUtilsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSData";
    
}

#pragma mark 16进制字符串->NSData  在OC中NSData就是16进制数据
- (IBAction)strToData:(id)sender
{
    /*
     如 e88c83e5 b88ce69c 9b
     注意一定要是16进制字符串，必须是2的整数倍长度 不然计算出来的结果会高位补零 字符串中不要有空格
     */
    
    NSString *hexStr = @"e88c83e5b88ce69c9b";
    NSData *data = [self toDataWithHexString:hexStr];
    
    NSLog(@"hexStr %@", hexStr);
    NSLog(@"data %@", data);
    
}

#pragma mark NSData->16进制字符串
- (IBAction)dataToStr:(id)sender
{
    NSString    *hexStr1    = @"e88c83e5b88ce69c9b";
    NSData      *data       = [self toDataWithHexString:hexStr1];
    NSString    *hexStr2    = [self toHexStringWithData:data];
    
    NSLog(@"hexStr1 %@", hexStr1);
    NSLog(@"data    %@", data);
    NSLog(@"hexStr2 %@", hexStr2);
    
}

#pragma mark 获取subData
- (IBAction)getSubData:(id)sender
{
    NSString *hexStr1 = @"e88c83e5b88ce69c9b";
    NSData   *data    = [self toDataWithHexString:hexStr1];
    NSData   *subData = [data subdataWithRange:NSMakeRange(4, 3)];//从index4开始 取3个长度 每一个索引 对应两个二进制数
    
    NSLog(@"data %@", data);
    NSLog(@"subData %@", subData);
    
    //还可以直接从字符串中获取，项目里面也可以将NSData转成字符串再从字符串中获取 然后转乘NSData
    
    
}

#pragma mark 获取NSData中的数值
- (IBAction)getValueInData:(id)sender
{
    
    
}

#pragma mark 10/16进制之间的转换
- (IBAction)exchangeHex:(id)sender
{
    
    
}

#pragma mark 获取bit中的前后位
- (IBAction)getBitBoth:(id)sender
{
    
    
}

#pragma mark 高位补零
- (IBAction)addZeroInHigh:(id)sender
{
    
    
}


//16进制字符串 转 NSData NSData就是16进制数据
- (NSData *)toDataWithHexString:(NSString *)str
{
    //注意一定要是16进制字符串，必须是2的整数倍长度 不然计算出来的结果会高位补零 字符串中不要有空格
    if (!str || [str length] == 0)
    {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    
    if ([str length] % 2 == 0)
    {
        range = NSMakeRange(0, 2);
    }
    else
    {
        range = NSMakeRange(0, 1);
    }
    
    for (NSInteger i = range.location; i < [str length]; i += 2)
    {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
    
}


- (NSString *)toHexStringWithData:(NSData *)data
{
    if (!data || [data length] == 0)
    {
        return @"";
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop)
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































- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
