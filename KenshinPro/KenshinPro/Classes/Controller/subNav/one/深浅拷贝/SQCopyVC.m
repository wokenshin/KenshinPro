//
//  SQCopyVC.m
//  KenshinPro
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "SQCopyVC.h"

@interface SQCopyVC ()

@end

@implementation SQCopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"深浅拷贝 demo";
    
//    [self testNSString];
//    [self testMStrin];
    [self testArray];
}

//非容器不可变对象
- (void)testNSString{
    NSString *str1 = @"非容器不可变对象";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    //str1 = @"注意！这里不是给str1的内存空间赋值，而是重新初始化了一个字符串对象赋值给str1";
    NSLog(@"str1_p : %p, class: %@", str1, [str1 class]);
    NSLog(@"str2_p : %p, class: %@", str2, [str2 class]);
    NSLog(@"str3_p : %p, class: %@", str3, [str3 class]);
    
    
    NSLog(@"str1:%@", str1);
    NSLog(@"str2:%@", str2);
    NSLog(@"str3:%@", str3);
    /*
     对于非容器不可变对象的copy为浅拷贝，mutableCopy为深拷贝
     浅拷贝获得的对象地址和原对象地址一致， 返回的对象为不可变对象
     深拷贝返回新的内存地址，返回对象为可变对象
     */
}

//非容器可变对象
- (void)testMStrin{
    
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    NSMutableString *str2 = [str1 copy];
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1_p : %p, class: %@", str1, [str1 class]);
    NSLog(@"str2_p : %p, class: %@", str2, [str2 class]);
    NSLog(@"str3_p : %p, class: %@", str3, [str3 class]);
    
    /*
     对于非容器可变对象的copy为深拷贝
     mutableCopy为深拷贝
     并且copy和mutableCopy返回对象都为可变对象
     */
}

//容器不可变对象
- (void)testArray{
    
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    
    
    
    
    NSArray *array = [NSArray arrayWithObjects:str1, @"非容器不可变对象", nil];
    NSArray *copyArray = [array copy];
    NSArray *mutableCopyArray = [array mutableCopy];
    
    NSLog(@"array_p: %p, class: %@", array, [array class]);
    NSLog(@"copyArray_p: %p, class: %@", copyArray, [copyArray class]);
    NSLog(@"mutableCopyArray_p: %p, class: %@", mutableCopyArray, [mutableCopyArray class]);
    
    NSLog(@"======原对象=====");
    NSLog(@"object_p: %p, class: %@", array[0], [array[0] class]);
    NSLog(@"object_p: %p, class: %@", array[1], [array[1] class]);
    
    NSLog(@"======copy对象=====");
    NSLog(@"object_p: %p, class: %@", copyArray[0], [copyArray[0] class]);
    NSLog(@"object_p: %p, class: %@", copyArray[1], [copyArray[1] class]);
    
    NSLog(@"======mutableCopy对象=====");
    NSLog(@"object_p: %p, class: %@", mutableCopyArray[0], [mutableCopyArray[0] class]);
    NSLog(@"object_p: %p, class: %@", mutableCopyArray[1], [mutableCopyArray[1] class]);
    
    
}




@end
