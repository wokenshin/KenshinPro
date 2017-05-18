//
//  FXW_CountDownButton.m
//  KenshinPro
//
//  Created by kenshin on 17/5/17.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_CountDownButton.h"
#import "Tools.h"

@interface FXW_CountDownButton()

@property (nonatomic, copy) FXW_CountDownButtonBlock            clickButtonCallback;

@property (nonatomic, assign) NSTimeInterval                    timeNum;
@property (nonatomic, strong) NSTimer                           *timer;
@property (nonatomic, strong) NSDate                            *startDate;


@end

@implementation FXW_CountDownButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //可以给不同的事件 设置不同的block
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        _countDownSecond = 60;//设置默认倒计时时间为 60s
    }
    return self;
    
}

#pragma mark 开始倒计时
- (void)startCountDown
{
    if (_timeNum <= 0)
    {
        _timeNum = _countDownSecond;//设置默认倒计时时间为60s
    }
    
    if (_timer == nil)//设置倒计时
    {
        //每间隔1s会去执行一次countDown
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(countDown) userInfo:nil repeats:YES];
        
        _startDate = [NSDate date];//记录倒计时时的时间
//        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    
    [self setTitle:[NSString stringWithFormat:@"还剩%d秒", (int)_timeNum] forState:UIControlStateNormal];
    
}

#pragma mark 倒计时_周期调用 <=0时 停止倒计时 并恢复默认样式
- (void)countDown
{
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];//计算从开始倒计时到此刻的时间差
    
    _timeNum = _countDownSecond - (NSInteger)(deltaTime+0.5);
    
    [self setTitle:[NSString stringWithFormat:@"还剩%d秒", (int)_timeNum] forState:UIControlStateNormal];
    
    if (_timeNum <= 0)
    {
        
        [self setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        _timeNum = _countDownSecond;
        
        [_timer invalidate];
        _timer = nil;
        
    }
    
}


- (void)clickAction
{
    if (_clickButtonCallback)
    {
        if (_timeNum <= 0 || _timeNum == 60)
        {
            [self startCountDown];
            _clickButtonCallback(YES, NO);
        }
        else//如果还在倒计时则不执行新的倒计时
        {
            NSLog(@"倒计时还在继续。。。");
            _clickButtonCallback(NO, YES);
        }
    }
    
}

- (void)clickButtonWithResultBlock:(FXW_CountDownButtonBlock)block
{
    _clickButtonCallback = block;
    
}

- (void)cleanTimer
{
    [_timer invalidate];
    _timer = nil;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}


@end
