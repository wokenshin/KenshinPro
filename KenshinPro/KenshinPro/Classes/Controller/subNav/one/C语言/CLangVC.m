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
    
    [self addDataWithTitle:@"指针常量" andDetail:@"2019-3-11"];
    [self addDataWithTitle:@"常量指针" andDetail:@"2019-3-11"];
    [self addDataWithTitle:@"指针的比较" andDetail:@"++, --, +, -"];
    [self addDataWithTitle:@"递减一个指针" andDetail:@"++, --, +, -"];
    [self addDataWithTitle:@"递增一个指针" andDetail:@"++, --, +, -"];
    [self addDataWithTitle:@"指针的算术运算" andDetail:@"++, --, +, -"];
    [self addDataWithTitle:@"C中的NULL指针" andDetail:@"2019-3-8"];
    [self addDataWithTitle:@"内存地址" andDetail:@"2019-3-8"];
    [self addDataWithTitle:@"指针" andDetail:@"2019-3-8"];
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"指针常量"]) {
        /*
         定义：又叫常指针，可以理解为常量的指针，也即这个是指针，但指向的是个常量，这个常量是指针的值（地址），而不是地址指向的值。
         
         */
        return;
    }
    if ([title isEqualToString:@"常量指针"]) {
        
        return;
    }
    if ([title isEqualToString:@"指针的比较"]) {
        /*
         指针可以用关系运算符进行比较，如 ==、< 和 >。如果 p1 和 p2 指向两个相关的变量，
         比如同一个数组中的不同元素，则可对 p1 和 p2 进行大小比较。
         下面的程序修改了上面的实例，只要变量指针所指向的地址小于或等于数组的最后一个元素的地址 &var[MAX - 1]，则把变量指针进行递增：
         */
        const int MAX = 3;
        int var[] = {10, 100, 1000};
        int i;
        int *ptr;
        /* 指针中第一个元素的地址 */
        ptr = var;
        i = 0;
        while (ptr<=&var[MAX -1]) {
            //C语言中%X的意思是以十六进制数形式输出整数
            printf("var[%d]的地址是%x\n", i, ptr);
            printf("var[%d]==%d\n", i, *ptr);
            
            /* 指向上一个位置 */
            ptr++;
            i++;
        }
        
        return;
    }
    if ([title isEqualToString:@"递减一个指针"]) {
        const int MAX = 3;
        int var[] = {10, 100, 1000};
        int i, *ptr;
        
         /* 指针中最后一个元素的地址 */
        ptr = &var[MAX-1];
        for (i = MAX; i > 0; i--) {
            printf("存储地址var[%d] = %d\n", i-1, ptr);//十进制输出
            printf("存储值  var[%d] = %d\n", i-1, *ptr);
            /* 移动到下一个位置 */
            ptr--;
        }
        
        return;
    }
    if ([title isEqualToString:@"递增一个指针"]) {
        const int MAX = 3;
        
        int var[] = {10, 100, 1000};
        int i, *ptr;
        
        //指针中的数组地址
        ptr = var;
        for (i = 0; i < MAX; i++) {
            //C语言中%X的意思是以十六进制数形式输出整数
            //%d 同上 十进制
            printf("存储地址：var[%d] = %d\n", i, ptr);
            printf("存储值： var[%d] = %d\n", i, *ptr);
            /* 移动到下一个位置 */
            ptr++;
        }
        
        return;
    }
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
