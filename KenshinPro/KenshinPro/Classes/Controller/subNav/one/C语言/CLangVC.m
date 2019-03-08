//
//  CLangVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/8.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "CLangVC.h"

//from：http://www.runoob.com/cprogramming/c-pointers.html
@interface CLangVC ()

@end

@implementation CLangVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initCLangVCUI];
    
    
}

- (void) initCLangVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"C语言";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}


- (void)loadData{
    
    [self addDataWithTitle:@"指针的算术运算" andDetail:@"++, --, +, -"];
    [self addDataWithTitle:@"C中的NULL指针" andDetail:@"2019-3-8"];
    [self addDataWithTitle:@"内存地址" andDetail:@"2019-3-8"];
    [self addDataWithTitle:@"指针" andDetail:@"2019-3-8"];
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"指针的算术运算"]) {
        int *ip = NULL;//NULL的地址是 0x0
        
        printf("ip 的地址是 %p\n", ip);
        
        ip++;
        printf("ip 的地址是 %p\n", ip);
        
        return;
    }
    if ([title isEqualToString:@""]){
        UIViewController *vc = [[UIViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"C中的NULL指针"]) {
        /*
         在变量声明的时候，如果没有确切的地址可以赋值，为指针变量赋一个 NULL 值是一个良好的编程习惯。
         赋为 NULL 值的指针被称为空指针。
         NULL 指针是一个定义在标准库中的值为零的常量。请看下面的程序
         */
        int *ip = NULL;
        printf("ip 的地址是 %p\n", ip);
        
        
        return;
    }
    if ([title isEqualToString:@"内存地址"]) {
        int  var1;
        char var2[10];
        printf("var1 变量的地址 %p\n", &var1);
        printf("var2 变量的地址 %p\n", &var2);
        //通过上面的实例，我们了解了什么是内存地址(0x7ffee0a71bfc)以及如何访问它。接下来让我们看看什么是指针
        return;
    }
    if ([title isEqualToString:@"指针"]) {
        int    *ip;    /* 一个整型的指针 */
        double *dp;    /* 一个 double 型的指针 */
        float  *fp;    /* 一个浮点型的指针 */
        char   *ch;    /* 一个字符型的指针 */
        /*
         所有指针的值的实际数据类型，不管是整型、浮点型、字符型，还是其他的数据类型，
         都是一样的，都是一个代表内存地址的长的十六进制数。不同数据类型的指针之间唯一的不同是，
         指针所指向的变量或常量的数据类型不同。
         
         如何使用指针？
         使用指针时会频繁进行以下几个操作：定义一个指针变量、把变量地址赋值给指针、
         访问指针变量中可用地址的值。这些是通过使用一元运算符 * 来返回位于操作数所指定地址的变量的值。
         下面的实例涉及到了这些操作：
         */
        
        int var = 20;//实际变量的声明
        int *ip2;    //指针变量的声明
        
        ip2 = &var;  //在指针变量中存储 var 的地址
        
        printf("var地址: %p\n", &var);
        
        /* 在指针变量中存储的地址 */
        printf("指针地址: %p\n", ip2);
        
        /* 使用指针访问值 */
        printf("访问ip2: %d\n", *ip2);
        
        
        
        return;
    }
    
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}




@end
