//
//  NSCodingVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSCodingVC.h"
#import "CusModel.h"
#import "RuntimeVC.h"

/*
 
 参考:http://blog.csdn.net/codywangziham01/article/details/25325557
 
 NSCoding 跟其他存储方式略有不同，他可以存储对象
 对象存储的条件是： 对象需要遵守 NSCoding 协议
 存储的时候需要 调用 encodeWithCoder 方法
 读取的时候需要调用initWithCoder 方法
 [NSKeyedArchiver archiveRootObject:stu toFile:path]; 存储
 NSKeyedUnarchiver unarchiveObjectWithFile:path 读取
 
 */
@interface NSCodingVC ()

@end

@implementation NSCodingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"NSCoding归档解档";
    [self toastBottom:@"请看控制台"];
    
}

#pragma mark 保存
- (IBAction)clickSave:(id)sender
{
    // 1.新的模型对象
    CusModel *model = [[CusModel alloc] init];
    model.name      = @"kenshin";
    model.age       = 20;
    model.height    = 1.55;
    
    // 2.归档模型对象
    // 2.1.获得Documents的全路径
    NSString *doc  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"cusModel.data"];// 2.2.获得文件的全路径
    BOOL flag = [NSKeyedArchiver archiveRootObject:model toFile:path];// 2.3.将对象归档
    if (flag)
    {
        [self toastBottom:@"归档成功"];
    }
    else
    {
        [self toastBottom:@"归档失败"];
    }
}

#pragma mark 读取
- (IBAction)clickRead:(id)sender
{
    
    NSString *doc  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];// 1.获得Documents的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"cusModel.data"];// 2.获得文件的全路径
    CusModel *stu  = [NSKeyedUnarchiver unarchiveObjectWithFile:path];// 3.从文件中读取CusModel对象
    
    if (stu)
    {
        [self toastBottom:stu.name];
        NSLog(@"%@ %d %f", stu.name, stu.age, stu.height);
    }
    else
    {
        [self toastBottom:@"请先归档后 在解档"];
    }
    
    
}

#pragma mark runtime的实现
- (IBAction)clickGJDByRuntime:(id)sender
{
    RuntimeVC *vc = [[RuntimeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
