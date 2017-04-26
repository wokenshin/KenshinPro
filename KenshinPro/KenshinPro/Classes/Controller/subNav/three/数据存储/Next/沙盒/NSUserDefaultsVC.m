//
//  NSUserDefaultsVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/25.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSUserDefaultsVC.h"

@interface NSUserDefaultsVC ()

@end

@implementation NSUserDefaultsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNSUserDefaultsVC];
    
}

- (void)initNSUserDefaultsVC
{
    self.navigationItem.title = @"NSUserDefaults的存储";
}

- (IBAction)saveNSString:(id)sender
{
    [FXWUD saveString:@"kenshin" forKey:@"KENSHIN"];
}

- (IBAction)readNSString:(id)sender
{
    NSString *name = [FXWUD getStringForKey:@"KENSHIN"];
    [self toast:[NSString stringWithFormat:@"NSString is %@", name]];
    
}

- (IBAction)saveBOOL:(id)sender
{
    [FXWUD saveBOOL:YES forKey:@"IS_FUNNY"];
}

- (IBAction)readBOOL:(id)sender
{
    BOOL isFunny = [FXWUD getBOOLForKey:@"IS_FUNNY"];
    if (isFunny)
    {
        [self toast:@"BOOL is funny"];
    }
    else
    {
        [self toast:@"保存 BOOL 失败"];
    }
}

- (IBAction)saveDouble:(id)sender
{
    [FXWUD saveDounle:3.1415926 forKey:@"PI"];
}

- (IBAction)readDouble:(id)sender
{
    double pi = [FXWUD getDoubleForKey:@"PI"];
    if (pi > 0)
    {
        [self toast:[NSString stringWithFormat:@"double is %f", pi]];
    }
    else
    {
        [self toast:@"读取 double 失败"];
    }
}

- (IBAction)saveNSInteger:(id)sender
{
    [FXWUD saveInteger:123123 forKey:@"ASD"];
}

- (IBAction)readNSInteger:(id)sender
{
    NSInteger i = [FXWUD getIntegerForkey:@"ASD"];
    if (i)
    {
        [self toast:[NSString stringWithFormat:@"NSInteger is %ld", i]];
    }
    else
    {
        [self toast:@"读取 NSInteger 失败"];
    }
}

- (IBAction)saveDic:(id)sender
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:@"努力" forKey:@"A"];
    [mDic setObject:@"奋斗" forKey:@"B"];
    [mDic setObject:@"幸福" forKey:@"C"];
    
    [FXWUD saveDic:mDic forKey:@"DIC_ABC"];
    
}

- (IBAction)readDic:(id)sender
{
    //不知道为什么 从沙盒里面取出来的字典 可能这结构和平时的字典有所不同
    NSDictionary *dic = [FXWUD getDicForKey:@"DIC_ABC"];
    if (dic)
    {
        [self toast:[NSString stringWithFormat:@"读取字典成功 %@", dic]];
    }
    else
    {
        [self toast:@"读取字典失败"];
    }
}

- (IBAction)saveArr:(id)sender
{
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        [mDic setObject:@"kenshin" forKey:@"A"];
        [mDic setObject:@"xun" forKey:@"B"];
        [mDic setObject:@"toma" forKey:@"C"];
        [mArr addObject:mDic];
    }
    [FXWUD saveArray:mArr forKey:@"ARR_NAME"];
}

- (IBAction)readArr:(id)sender
{
    //沙盒里面保存的数组也很奇怪 debug的时候 看不到数组中的内容
    NSArray *arr = [FXWUD getArrayForKey:@"ARR_NAME"];
    if (arr)
    {
        [self toast:[NSString stringWithFormat:@"读取数组成功 %@", arr]];
    }
    else
    {
        [self toast:@"读取数组失败"];
    }
}

//参考:https://my.oschina.net/u/1245365/blog/294449 [使用归档 将对象转成NSData来存储 取出来的时候再解档]
- (IBAction)saveCustomObj:(id)sender
{
    [self toast:@"个人不是很喜欢这种方式 这里不做介绍了， 百度一大堆"];
}

- (IBAction)readCustomObj:(id)sender
{
    [self toast:@"个人不是很喜欢这种方式 这里不做介绍了， 百度一大堆"];
}





















- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
