//
//  ARCVC.m
//  KenshinPro
//
//  Created by apple on 2018/11/29.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "ARCVC.h"

@interface ARCVC ()

@end

@implementation ARCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //是要在非ARC环境之下
    //[self demo1];
//    [self demo2];
//    [self demo3];
    [self demo4];
    
    
    
}

- (void)demo4{
    
    
}

- (void)demo3{
    
    id obj0 = [[NSObject alloc] init];
    
    id obj1 = [obj0 object];//这行代码执行之后就崩溃了：-[NSObject object]: unrecognized selector sent to instance 0x6
    
    [obj1 release];
    NSLog(@"break!");
    
}

- (void)demo2{
    //自己生成并持有对象
    id obj = [[NSMutableArray alloc] init];
    //释放对象
    //指向对象的指针仍然被保留在变量obj中，貌似能够访问，但对象一经释放，绝对不可访问
    [obj release];
    
    //一访问就GG
    NSInteger count = [obj count];
    count = 1;
    NSLog(@"野指针!");//EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
    
}

- (void)demo1{
    //alloc/new/copy/mutableCopy 之外的方法取得的对象
    //取得的对象存在，但自己不z持有该对象
    
    id obj = [NSMutableArray array];
    NSInteger  count = [obj retainCount];
    NSLog(@"count == %ld", (long)count);
    [obj retain];
    count = [obj retainCount];
    NSLog(@"count == %ld", (long)count);
    NSLog(@"我擦");
}


@end
