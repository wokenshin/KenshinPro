//
//  DefineVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/7/26.
//  Copyright © 2017年 Kenshin. All rights reserved.
//
#define FXW_MIN(A,B) A<B ? A:B

#define FXW_MIN2(A,B) (A < B ? A : B)

#define FXW_MIN3(A,B) ((A) < (B) ? (A) : (B))

#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

#import "DefineVC.h"

//参考 https://onevcat.com/2014/01/black-magic-in-macro/
@interface DefineVC ()

@end

@implementation DefineVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"宏定义";
    [self toast:@"请查看代码"];
    [self testDefine];
    [self testLog];
    
    
}

- (void)testDefine
{
    //1.写一个简单的宏 用来获取两个值中较小的那个值
    NSLog(@"%d", FXW_MIN(100, 20));
    NSLog(@"%d", FXW_MIN(100, 200));
    
    //上面的输出没有问题 bug！。。。
    NSLog(@"%d", 2*FXW_MIN(3, 4));
    //输出结果是 4   WTF!?
    
    /*
     看起来似乎不可思议，但是我们将宏展开就知道发生什么了
     
     int a = 2 * MIN(3, 4);
     // => int a = 2 * 3 < 4 ? 3 : 4;
     // => int a = 6 < 4 ? 3 : 4;
     // => int a = 4;
     
     嘛，写程序这个东西，bug出来了，原因知道了，事后大家就都是诸葛亮了。因为小于和比较符号的优先级是较低的，所以乘法先被运算了，修正非常简单嘛，加括号就好了。
     
     //Version 2.0
     #define FXW_MIN2(A,B) (A < B ? A : B)
     */
    NSLog(@"%d", 2*FXW_MIN2(3, 4));
    
    /*
     这次2 * MIN(3, 4)这样的式子就轻松愉快地拿下了。经过了这次修改，我们对自己的宏信心大增了…直到，某一天一个怒气冲冲的同事跑来摔键盘，然后给出了一个这样的例子：
     */
    NSLog(@"%d", FXW_MIN2(3, 4 < 5 ? 4 : 5));
    //输出结果是 4   WTF!?
    
    /*
     同样展开看看呢
     int a = MIN(3, 4 < 5 ? 4 : 5);
     // => int a = (3 < 4 < 5 ? 4 : 5 ? 3 : 4 < 5 ? 4 : 5);  //希望你还记得运算符优先级
     //  => int a = ((3 < (4 < 5 ? 4 : 5) ? 3 : 4) < 5 ? 4 : 5);  //为了您不太纠结，我给这个式子加上了括号
     //   => int a = ((3 < 4 ? 3 : 4) < 5 ? 4 : 5)
     //    => int a = (3 < 5 ? 4 : 5)
     //     => int a = 4
     
     找到问题所在了，由于展开时连接符号和被展开式子中的运算符号优先级相同，导致了计算顺序发生了变化，实质上和我们的1.0版遇到的问题是差不多的，还是考虑不周。那么就再严格一点吧，3.0版！
     #define MIN(A,B) ((A) < (B) ? (A) : (B))
     */
    
    //然而...
    float a = 1.0f;
    float b = FXW_MIN3(a++, 1.5f);
    printf("a=%f, b=%f",a,b);
    // => a=3.000000, b=2.000000
    //后面的内容有点多 还是去看本demo的大神些的原文吧
    
}

- (void)testLog
{
    NSArray *array = @[@"Hello", @"My", @"Macro"];
    NSLog (@"The array is %@", array);
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
