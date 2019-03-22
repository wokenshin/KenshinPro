//
//  MSVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "MSVC.h"
#import "OCFSJZVC.h"
#import "GCDSSVC.h"

@interface MSVC ()

@end

@implementation MSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initJTiOSDevVCUI];
    
}

- (void) initJTiOSDevVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"面试";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}


- (void)loadData{
    
    [self addDataWithTitle:@"用递归算法求1到n的和" andDetail:@"2109-3-13"];
    [self addDataWithTitle:@"不借用第三个变量，如何交换两个变量的值" andDetail:@"不借用第三个变量，如何交换两个变量的值"];
    [self addDataWithTitle:@"GCD死锁及解决方案" andDetail:@"2019-3-13"];
    [self addDataWithTitle:@"BAD_ACCESS" andDetail:@"2019-3-6 僵尸模式&Analyze分析"];
    [self addDataWithTitle:@"hash" andDetail:@"2019-3-5"];
    [self addDataWithTitle:@"说一下OC的反射机制" andDetail:@"2019-3-1"];
    [self addDataWithTitle:@"__block修饰的变量为什么能在block里面能改变其值？"
                 andDetail:@"__block修饰的变量为什么能在block里面能改变其值？"];
    
    

    
}
/*
 f(3) = return 3 + f(2); 3 + 2 + 1
 f(2) = return 2 + f(1); 3
 f(1) = return 1 + f(0); 1
 */
- (long)sumN:(long)n{
    if(n <= 0){
        return 0;
    }
    if(n == 1){
        return 1;
    }
    return n + [self sumN:n-1];
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"用递归算法求1到n的和"]) {
        NSLog(@"%ld", [self sumN:100]);
        return;
    }
    if ([title isEqualToString:@"不借用第三个变量，如何交换两个变量的值"]) {
        /*
         from:https://blog.csdn.net/pt666/article/details/70521309
         这里说的变量是 基本数据类型
         方法一：加减法【缺点 怕计算数据过大 丢精度】
         方法二：异或运算【缺点 不够直观】
         综上 通常还是使用第三方变量更简单明了
         */
        
        int a = 5;
        int b = 10;
        
        NSLog(@"加减法换值");
        NSLog(@"修改前：a==%d, b==%d", a, b);
        a = a + b;// a = 15
        b = a - b;// b = 15 - 10 == 5
        a = a - b;// a = 15 - 5  == 10
        NSLog(@"修改后：a==%d, b==%d", a, b);
        
        int x = 5;
        int y = 10;
        NSLog(@"异或换值");
        NSLog(@"修改前：x==%d, y==%d", x, y);
        x = x^y;// x = 0101 ^ 1010 == 1111 == 15
        y = x^y;// y = 1111 ^ 1010 == 0101 == 5
        x = x^y;// x = 1111 ^ 0101 == 1010 == 10
        NSLog(@"修改后：x==%d, y==%d", x, y);
        
        return;
    }
    if ([title isEqualToString:@"GCD死锁及解决方案"]) {
        GCDSSVC *vc = [[GCDSSVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"说一下OC的反射机制"]) {
        OCFSJZVC *vc = [[OCFSJZVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"BAD_ACCESS"]) {
        //https://blog.csdn.net/cordova/article/details/71774003
        return;
    }
    if ([title isEqualToString:@"hash"]) {
        //https://www.jianshu.com/p/2a71b027b723?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
        
        return;
    }
    if ([title isEqualToString:@"__block修饰的变量为什么能在block里面能改变其值？"]) {
        //from:https://www.jianshu.com/p/a1c8532e172d
        /*
         我们都知道：Block不允许修改外部变量的值，这里所说的外部变量的值，
         指的是栈中指针的内存地址。__block 所起到的作用就是只要观察到该变量被 block 所持有，
         就将“外部变量”在栈中的内存地址放到了堆中。进而在block内部也可以修改外部变量的值
         */
        __block int a = 0;
        NSLog(@"定义前：%p", &a);          //栈区
        void (^foo)(void) = ^{
            a = 1;
            NSLog(@"block内部：%p", &a);  //堆区
        };
        NSLog(@"定义后：%p", &a);         //堆区
        foo();
        
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}

@end
