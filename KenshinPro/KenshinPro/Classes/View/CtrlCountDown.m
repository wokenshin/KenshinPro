//
//  CtrlCountDown.m
//  Sanhe
//
//  Created by kenshin on 16/11/22.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "CtrlCountDown.h"

@interface CtrlCountDown()

//倒计时
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, assign) NSTimeInterval    timeNum;//60s

@property (nonatomic, assign) NSTimeInterval    backTime;//后台时间
@property (nonatomic, assign) NSTimeInterval    forgTime;//前台时间
@property (nonatomic, assign) NSTimeInterval    remberTime;//保存定时器进入后台时的时间

@property (nonatomic, assign) BOOL              countingFlag;//判断是否正在倒计时

@end

@implementation CtrlCountDown


- (void)setCountDownTime:(NSInteger)time
{
    _timeNum = time;
    
    //监听进入前台 和 进入后台的通知
    [self listenAppState];
    
}

- (void)listenAppState
{
    //APP进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(realStateInForeground)
                                                 name:@"APP_INTO_FOREGROUND" object:nil];
    
    //APP进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(realStateInBackground)
                                                 name:@"APP_INTO_BACKGROUND" object:nil];
    
}

#pragma mark 倒计时
- (void)startCountDown
{
    //网络请求，请求成功后 开始倒计时
    if (_timer == nil)//设置倒计时
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    _countingFlag = YES;
    [self setTitle:@"还剩60秒" forState:UIControlStateNormal];
}

#pragma mark 关闭倒计时
- (void)closeCountDown
{
    [_timer invalidate];
    _timer = nil;
    
}

- (BOOL)isCountingDown
{
    return _countingFlag;
}

//进入后台 保存当前时间 获取准确倒计时时间【因为倒计时 在进入后台后5秒后会停止】
- (void)realStateInBackground
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    _backTime = time;
    _remberTime = _timeNum;//将定时器的时间保存起来 因为进入后台的时候 定时器的时间还在周期减少
//    NSLog(@"进入后台：%f", _backTime);
}

//进入前台 计算时间差 获取准确倒计时时间【因为倒计时 在进入后台后5秒回停止】
- (void)realStateInForeground
{
    if (_timer == nil)
    {
        return;
    }
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    _forgTime = time;
//    NSLog(@"进入前台：%f", _forgTime);
    
    //时间差
    NSTimeInterval timeCha = _forgTime - _backTime;
    _timeNum = _remberTime;//将定时器进入后台时的时间赋值给定时器
    
    NSLog(@">>>定时器时间：%f", _timeNum);
    NSLog(@">>>进入后台时：%f", _backTime);
    NSLog(@">>>进入前台时：%f", _forgTime);
    NSLog(@">>>时间差   ：%f", timeCha);
    
    _timeNum = _timeNum - timeCha;
    
    
    NSLog(@">>>显示的时间:%f", _timeNum);
    
    //将保存的时间清零
    _forgTime = 0;
    _backTime = 0;
    
}

#pragma mark 倒计时_周期调用 <=0时 停止倒计时 并恢复默认样式
- (void)countDown
{
    _timeNum--;
    
    [self setTitle:[NSString stringWithFormat:@"还剩%ld秒", (long)_timeNum] forState:UIControlStateNormal];
    if (_timeNum <= 0) {
        
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        _timeNum = 60;
        _countingFlag = NO;
        
        [_timer invalidate];
        _timer = nil;
        
    }
    
}


@end
