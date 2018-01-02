//
//  BlockVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BlockVC.h"

@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"代码块";
    
    //http://www.jianshu.com/p/404ff9d3cd42 代码块内修改外部变量 __block Type var = x;
    //[self test1];
    //[self test2];
    
    //other
    //除了返回的参数是block的使用之外，其余的 可以参考 SmartDevice SDK，或者参考 二次封装的AFN AFN_FXW.h
}

- (void)test1
{
    __block int a = 0;//如果这里不用 __block 修饰的话 代码块内部无法修改此变量
    NSLog(@"代码块外部 a == %d 地址A:%p", a, &a);//栈区
    void (^foo)(void) = ^{
        a = 1;
        NSLog(@"代码块内部 a == %d 地址B:%p", a, &a);//堆区
    };
    foo();
    NSLog(@"代码块外部 a == %d 地址C:%p", a, &a);//堆区
    
    //这里，a的值被修改为1
    //输出发现  a变量在进入block前的地址A 和 进入block后的地址B 不相同， B和block之后的地址C 相同
}

//似懂非懂
- (void)test2
{
    NSMutableString *a = [NSMutableString stringWithString:@"Tom"];
    NSLog(@"定义前：   a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);//a在栈区
    
          void (^foo)(void) = ^{
              a.string = @"Jerry";
              NSLog(@"block内部：a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);//a在栈区
//              a = [NSMutableString stringWithString:@"William"]; //需要外部定义为 __block 才可以修改
          };
    
        foo();
        NSLog(@"定义后：   a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);//a在栈区
    
    /*
     这里的a已经由基本数据类型，变成了对象类型。对象类型，block会对对象类型的指针进行copy，copy到堆中，但并不会改变该指针所指向的堆中的地址，所以在上面的示例代码中，block体内修改的实际是a指向的堆中的内容。
     
     但如果我们尝试像上面图片中的65行那样做，结果会编译不通过，那是因为此时你在修改的就不是堆中的内容，而是栈中的内容。
     
     上文已经说过：Block不允许修改外部变量的值，这里所说的外部变量的值，指的是栈中指针的内存地址。
     */
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
