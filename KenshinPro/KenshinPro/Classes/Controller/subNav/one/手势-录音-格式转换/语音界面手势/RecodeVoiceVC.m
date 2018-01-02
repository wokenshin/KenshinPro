//
//  RecodeVoiceVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "RecodeVoiceVC.h"


@interface RecodeVoiceVC ()

@property (weak, nonatomic) IBOutlet UIButton   *btn;
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, assign) NSUInteger        recodeVoiceLength;//最长为60s 最短为2s

@end

@implementation RecodeVoiceVC

/*
 功能：长按0.5s后开始录音，录音最多为10s，录音5s后开始提示剩余时间
 长按事件触发后 开始录音，
 结束录音后，可以播放录音，对录音进行转码【转码是为了在实际项目中 减少流量】
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"手势->录音";
    [self initGesture];
    
}

#pragma mark 初始化手势
- (void)initGesture
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(longTapStartRecodeVoice:)];
    recognizer.minimumPressDuration = 0.5; //设置最小长按时间；默认为0.5秒
    [_btn addGestureRecognizer:recognizer];
    _btn.userInteractionEnabled = YES;
    
}

//长按事件
- (void)longTapStartRecodeVoice:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)//长按开始
    {
        //更新UI状态
        [_btn setTitle:@"松开 结束" forState:UIControlStateNormal];
        _btn.backgroundColor = RGB(115, 115, 115);
        _recodeVoiceLength = 0;//初始化录音时长
        
        if (_timer == nil)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                    selector:@selector(recodingVoice)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    }
    if(recognizer.state == UIGestureRecognizerStateEnded)//长按结束
    {
        [self stopRecodeVoice];
    }
    
}

#pragma mark 开始录音
- (void)recodingVoice
{
    _recodeVoiceLength++;
    NSLog(@"正在录音...%zds", _recodeVoiceLength);
    if (_recodeVoiceLength >= 5)//实际项目 可能为 >=50
    {
        [self toastBottom:[NSString stringWithFormat:@"剩余%zd秒", 10 - _recodeVoiceLength]];//这里只允许录10s
    }
    if (_recodeVoiceLength >= 10)//结束录音
    {
        [self stopRecodeVoice];
    }
    
}

#pragma mark 结束录音
- (void)stopRecodeVoice
{
    //回复UI状态
    [_btn setTitle:@"按住 说话" forState:UIControlStateNormal];
    _btn.backgroundColor = RGB(253, 106, 75);
    
    //清空定时器
    [_timer invalidate];
    _timer = nil;
    
    //判断录音时长
    if (_recodeVoiceLength <=3)
    {
        [self toast:@"说话时间太短"];
    }
    else
    {
        [self toast:@"发送录音..."];
    }
    
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
