//
//  GCDSSVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "GCDSSVC.h"

/*
 from:https://www.jianshu.com/p/014c291e6ee2 [文章不错 建议直接看文章]
 
 死锁
 1、定义：
 所谓死锁，通常指有两个线程T1和T2都卡住了，并等待对方完成某些操作。T1不能完成是因为它在等待T2完成。
 但T2也不能完成，因为它在等待T1完成。于是大家都完不成，就导致了死锁（DeadLock）。
 
 ？？？：这里的「等待」是什么意思呢，什么情况下会出现等待呢
 
 2、产生死锁的条件：
 产生死锁的四个必要条件：
 （1） 互斥条件：一个资源每次只能被一个进程使用。
 （2） 请求与保持条件：一个进程因请求资源而阻塞时，对已获得的资源保持不放。
 （3） 不剥夺条件:进程已获得的资源，在末使用完之前，不能强行剥夺。
 （4） 循环等待条件:若干进程之间形成一种头尾相接的循环等待资源关系。[比如 A需要B的资源，B需要A的资源]
  这四个条件是死锁的必要条件，只要系统发生死锁，这些条件必然成立，而只要上述条件之
  一不满足，就不会发生死锁。
 
 
 
 */
@interface GCDSSVC ()

@end

@implementation GCDSSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GCD死锁及解决方案";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"111===current thread:%@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"222===current thread:%@",[NSThread currentThread]);
        });
        NSLog(@"333===current thread:%@", [NSThread currentThread]);
    });
    

}

- (IBAction)deadLockTypicalCode:(id)sender {
    //导致死锁的典型代码
    //比如这个最简单的OC命令行程序就会导致死锁，运行后不会看到任何结果。
    @autoreleasepool {
        NSLog(@"这里可以执行");
//        dispatch_async(dispatch_get_main_queue(), ^(void){//异步函数都不会死锁
//            NSLog(@"async 可以执行");
//        });
        dispatch_sync(dispatch_get_main_queue(), ^(void){//同步主线程
            NSLog(@"sync 这里死锁了");
        });
    }
    /*
     疑问：
     1，同步执行：比如这里的dispatch_sync，这个函数会把一个block加入到指定的队列中，而且会一直等到执行完blcok，
     这个函数才返回。因此在block执行完之前，调用dispatch_sync方法的线程是阻塞的。
     ???啥意思？自动释放池执行完吗？自动释放池不是代码块。没搞懂为什么这里会死锁。
     
     自己的理解：在同步队列(这里是主队列)中，同步添加主队列导致了死锁，好比是向一根管子里插入一根一摸一样规格的管子，这样的比如不是很恰当
     但是 在队列中同步另外一个队列就不回这样，好比向一根管子里插入一根更细的管子。
     
     如下：
     
     dispatch_queue_t queue = dispatch_queue_create("Kenshin", nil);
     dispatch_sync(queue, ^(void){//这里的同步函数 是在串行队列 “Kenshin”中执行的
     NSLog(@"这个也不会死锁");
     
     });
     */
}

//同步的 向串行队列中添加block 不一定会发生死锁
- (IBAction)syncSerialQueueAddBlock:(id)sender {
    
    dispatch_queue_t queue = dispatch_queue_create("Kenshin", nil);
    dispatch_sync(queue, ^(void){//这里的同步函数 是在串行队列 “Kenshin”中执行的
        NSLog(@"这个也不会死锁");
    });
    
    /*
     事实上，导致死锁的原因一定是：
     在某一个串行队列中，同步的向这个串行队列添加block。
     */
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"马德这样也死锁");
//    });
    
}

@end
