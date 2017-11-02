//
//  HTCZXCVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "HTCZXCVC.h"

@interface HTCZXCVC ()

@property (weak, nonatomic) IBOutlet UIImageView                    *imgView;
@property (nonatomic, strong) NSThread                              *thread;

@end

@implementation HTCZXCVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"后台常驻线程";
    
    /*
     我们在开发应用程序的过程中，如果后台操作特别频繁，经常会在子线程做一些耗时操作（下载文件、后台播放音乐等），我们最好能让这条线程永远常驻内存。
     那么怎么做呢？
     添加一条用于常驻内存的强引用的子线程，在该线程的RunLoop下添加一个Sources，开启RunLoop。
     具体实现过程如下：
     
     1.在项目的ViewController.m中添加一条强引用的 thread 线程属性
     2.在viewDidLoad中创建线程self.thread，使线程启动并执行run1方法
     
     3.运行之后发现打印了----run1-----，而未开启RunLoop则未打印。
     这时，我们就开启了一条常驻线程，下边我们来试着添加其他任务，除了之前创建的时候调用了run1方法，我们另外在点击的时候调用run2方法。
     那么，我们在touchesBegan中调用PerformSelector，从而实现在点击屏幕的时候调用run2方法
     
     经过运行测试，除了之前打印的----run1-----，每当我们点击屏幕，都能调用----run2------。
     这样我们就实现了常驻线程的需求
     
     */
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1) object:nil];
    [self.thread start];// 开启线程
    
}


- (IBAction)clickBtn:(id)sender
{
    // 利用performSelector，在self.thread的线程中调用run2方法执行任务
    [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:NO];
    
}

- (void)run1
{
    // 这里写任务
    NSLog(@"----run1-----");
    
    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
    NSLog(@"未开启RunLoop");
    
}

- (void)run2
{
    NSLog(@"----run2------");
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
