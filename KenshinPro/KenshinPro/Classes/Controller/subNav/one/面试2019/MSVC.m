//
//  MSVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "MSVC.h"
#import "OCFSJZVC.h"

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
    
    [self addDataWithTitle:@"说一下OC的反射机制" andDetail:@"2019-3-1"];
    [self addDataWithTitle:@"__block修饰的变量为什么能在block里面能改变其值？" andDetail:@"__block修饰的变量为什么能在block里面能改变其值？"];
    [self addDataWithTitle:@"hash" andDetail:@"2019-3-5"];
    [self addDataWithTitle:@"BAD_ACCESS" andDetail:@"2019-3-6 僵尸模式&Analyze分析"];
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
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
