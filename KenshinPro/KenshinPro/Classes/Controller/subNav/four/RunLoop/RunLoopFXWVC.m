//
//  RunLoopFXWVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RunLoopFXWVC.h"
#import "RunloopStatusFXWVC.h"
#import "DelayShowImgVC.h"
#import "HTCZXCVC.h"

@interface RunLoopFXWVC ()

@property (nonatomic, strong) NSTimer                   *timer1;
@property (nonatomic, strong) NSTimer                   *timer2;

@end

@implementation RunLoopFXWVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Runloop";
    
    _timer1 = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        static int count = 0;
        NSLog(@"%s - %d",__func__,count++);
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:NSDefaultRunLoopMode];
    
    //Runloop在scrollView进行拖拽的时候会进入UITrackingRunLoopMode模式，退出拖拽的时候则会回到NSDefaultRunLoopMode模式
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_timer1 invalidate];
    [_timer2 invalidate];
    
}

#pragma mark 点击我后 再滑动 再看控制台
- (IBAction)clickBtn:(id)sender
{
    //需要用到 NSRunLoopCommonModes 占位模式
    [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:NSRunLoopCommonModes];
    //这样 设置之后 再次滑动UI的时候 timer就会继续执行 而不会进入 UITrackingRunLoopMode模式
    
}

#pragma mark 耗时操作
- (IBAction)clickTimeConsumingCtrl:(id)sender
{
    [_timer1 invalidate];//把 地一个 例子中的time释放掉 排除干扰项
    
//    1.主线程中的耗时操作 会阻塞UI 在滑动UI的时候 会出现卡顿
//    _timer2 = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        static int count2 = 0;
//        [NSThread sleepForTimeInterval:1];
//        //休息一秒钟，模拟耗时操作
//        NSLog(@"%s - %d",__func__,count2++);
//    }];
//
//    [[NSRunLoop currentRunLoop] addTimer:_timer2 forMode:NSRunLoopCommonModes];
    
    /*
     当进入block的时候，先创建了timer，并且也把timer也把timer加入到runloop中，但是很重要的一点
     子线程中Runloop不会自动运行，需要手动运行，
     因为这里没有运行Runloop，所以timer就被释放掉了，所以导致了啥都没有
     */
    //子线程中的耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //这里不会有循环引用
        _timer2 = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
            static int count = 0;
            [NSThread sleepForTimeInterval:1];
            //休息一秒钟，模拟耗时操作
            NSLog(@"%s - %d",__func__,count++);
        }];
        [[NSRunLoop currentRunLoop] addTimer:_timer2 forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run]; //如果不添加本行代码 在子线程中是不会 自动运行 Runloop的
    });
    
}

#pragma mark Runloop状态
- (IBAction)clickBtnPushRunloopStatusVC:(id)sender
{
    RunloopStatusFXWVC *vc = [[RunloopStatusFXWVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 延迟显示图片
- (IBAction)clickBtnDelayShowPic:(id)sender
{
    DelayShowImgVC *vc = [[DelayShowImgVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 后台常驻线程
- (IBAction)clickBtnBackAliveThread:(id)sender
{
    HTCZXCVC *vc = [[HTCZXCVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
