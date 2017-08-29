//
//  NSDataUtilsVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/7/13.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSDataUtilsVC.h"
#import "NSString+FXW.h"
#import "NSData+FXW.h"

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
    NSData *data = [hexStr fxw_hexStrToData];
    
    NSLog(@"hexStr %@", hexStr);
    NSLog(@"data %@", data);
    
}

#pragma mark NSData->16进制字符串
- (IBAction)dataToStr:(id)sender
{
    NSString    *hexStr1    = @"e88c83e5b88ce69c9b";
    NSData      *data       = [hexStr1 fxw_hexStrToData];
    NSString    *hexStr2    = [data fxw_toHexStr];
    
    
    NSLog(@"hexStr1 %@", hexStr1);
    NSLog(@"data    %@", data);
    NSLog(@"hexStr2 %@", hexStr2);
    
}

#pragma mark 获取subData
- (IBAction)getSubData:(id)sender
{
    NSString *hexStr1 = @"e88c83e5b88ce69c9b";
    NSData   *data    = [hexStr1 fxw_hexStrToData];
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







- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
