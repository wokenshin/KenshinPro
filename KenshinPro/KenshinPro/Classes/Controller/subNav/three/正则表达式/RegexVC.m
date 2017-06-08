//
//  RegexVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RegexVC.h"


/**
 感觉正则表达式的内容还是比较多的，至少学习了之后发现很容易忘记。但是掌握了基本的概念和简单的使用方法还是有必要的
 
 iOS中正则表达式的三种使用方式：http://www.cnblogs.com/wlsxmhz/p/5580671.html
 学习网站：https://deerchao.net/tutorials/regex/regex.htm [基础部分可以认真看一下，高级进阶的部分随便看看就差不多了，一般也用不了]
 学习网站：http://www.cocoachina.com/ios/20150415/11568.html[相对于上一篇文章，要简单很多，也是针对于iOS的]
 工具网站：http://regex.zjmainstay.cn/
 */
@interface RegexVC ()

@property (weak, nonatomic) IBOutlet UITextField *text;


@end

@implementation RegexVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRegexVCUI];
    [self testFunc];
    
    NSString *strLHV = [[NSString alloc] initWithFormat:@"%1x", 15];
    NSLog(@"%@", strLHV);
    NSLog(@"");
    
}

- (void)initRegexVCUI
{
    self.navigationItem.title = @"正则表达式";
    
}

- (void)testFunc
{
    /*
     丰富已有的工具类 RegexUtil
     1.验证手机号
     2.验证邮箱
     3.验证密码
     4.验证 限定范围内的字符串<例如 验证某一类蓝牙设备> 等等
     */
    
    [self matchPhoneNo];//匹配手机号
    [self matchEmail];//匹配邮箱
    
    
}

#pragma mark 验证手机号
- (void)matchPhoneNo
{
    NSString *str1 = @"18385090000";
    NSString *str2 = @"183850900001";
    NSString *str3 = @"1838509000";
    NSString *str4 = @"1838509000A";
    
    //NSString *regex = @"^[1][3|4|5|7|8|9]\\d{9}$";//这里注释掉的代码 效果和下面一致
    NSString *regex = @"^[1][345789]\\d{9}$";//这里的[345789] 其实就是这段集合中的其中一个匹配的意思 3 or 4 or 5 ...
    //13/14/15/17/18/19+9个数字
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isValid1 = [predicate evaluateWithObject:str1];
    BOOL isValid2 = [predicate evaluateWithObject:str2];
    BOOL isValid3 = [predicate evaluateWithObject:str3];
    BOOL isValid4 = [predicate evaluateWithObject:str4];
    
    NSLog(@"验证手机号");
    [self printLogWithBool:isValid1 str:str1];
    [self printLogWithBool:isValid2 str:str2];
    [self printLogWithBool:isValid3 str:str3];
    [self printLogWithBool:isValid4 str:str1];
    
}

#pragma mark 验证邮箱
- (void)matchEmail
{
    NSString *str1 = @"wokenshin@vip.qq.com";
    NSString *str2 = @"asdnqed@sdkanf.";
    NSString *str3 = @"abc.@.acc.com";
    NSString *str4 = @"313911762@qq.com";

    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isValid1 = [predicate evaluateWithObject:str1];
    BOOL isValid2 = [predicate evaluateWithObject:str2];
    BOOL isValid3 = [predicate evaluateWithObject:str3];
    BOOL isValid4 = [predicate evaluateWithObject:str4];
    
    NSLog(@"验证邮箱");
    [self printLogWithBool:isValid1 str:str1];
    [self printLogWithBool:isValid2 str:str2];
    [self printLogWithBool:isValid3 str:str3];
    [self printLogWithBool:isValid4 str:str1];
    
}

- (void)printLogWithBool:(BOOL)isValid str:(NSString *)str
{
    if (isValid)
    {
        NSLog(@"%@:合法的字符串", str);
    }
    else
    {
        NSLog(@"%@:不合法字符串", str);
    }
}

- (IBAction)clickCheckPhoneNo:(id)sender
{
    NSString *str = _text.text;
    if (str.length < 1)
    {
        [self toast:@"请输入字符文本"];
        return;
    }
    
    NSString *regex = @"^[1][345789]\\d{9}$";//这里的[345789] 其实就是这段集合中的其中一个匹配的意思 3 or 4 or 5 ...
    //13/14/15/17/18/19+9个数字
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isValid = [predicate evaluateWithObject:str];

    if (isValid)
    {
        [self toast:@"手机号码正确"];
    }
    else
    {
        [self toast:@"手机号码错误"];
    }
    
}

- (IBAction)clickCheckEmail:(id)sender
{
    NSString *str = _text.text;
    if (str.length < 1)
    {
        [self toast:@"请输入字符文本"];
        return;
    }
    
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isValid = [predicate evaluateWithObject:str];
    
    if (isValid)
    {
        [self toast:@"邮箱正确"];
    }
    else
    {
        [self toast:@"邮箱错误"];
    }
    
}



- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
