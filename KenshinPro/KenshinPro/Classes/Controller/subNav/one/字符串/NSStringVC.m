//
//  NSStringVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSStringVC.h"

@interface NSStringVC ()

@end

@implementation NSStringVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"字符串";
    
    /*
     
     1.截取字符串
     
     NSString*string =@"sdfsfsfsAdfsdf";
     string = [string substringToIndex:7];//截取掉下标7之后的字符串
     NSLog(@"截取的值为：%@",string);
     [string substringFromIndex:2];//截取掉下标2之前的字符串
     NSLog(@"截取的值为：%@",string);
     
     
     2.匹配字符串
     NSString*string =@"sdfsfsfsAdfsdf";
     NSRangerange = [stringrangeOfString:@"f"];//匹配得到的下标
     NSLog(@"rang:%@",NSStringFromRange(range));
     string = [string substringWithRange:range];//截取范围类的字符串
     NSLog(@"截取的值为：%@",string);
     
     
     3.分隔字符串
     NSString*string =@"sdfsfsfsAdfsdf";
     
     NSArray *array = [string componentsSeparatedByString:@"A"]; //从字符A中分隔成2个元素的数组
     NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
     
     */
}

#pragma mark 字符串->字节
- (IBAction)clickButtonStrToByte:(id)sender
{
    //参考:http://blog.csdn.net/u012198553/article/details/40595825
    //不要问我这有什么用，项目里面用到的。 有时间还是去看下关于 二进制，字节啥的东西吧。基础的东西全忘了
    
    NSString *str = [NSString stringWithFormat:@"HelloWorld"];
    NSData *dataStr = [str dataUsingEncoding: NSUTF8StringEncoding];
//    dataStr.bytes
    [self toastBottom:@"sta->data->data.bytes"];
    
    
    
}

//插入字符
- (IBAction)insertStr:(id)sender
{
    
    
}

//删除字符
- (IBAction)deleteStr:(id)sender
{
    
    
}

//修改字符
- (IBAction)changeStr:(id)sender
{
    
    
}

//查询字符
- (IBAction)selectStr:(id)sender
{
    
    
}













- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
