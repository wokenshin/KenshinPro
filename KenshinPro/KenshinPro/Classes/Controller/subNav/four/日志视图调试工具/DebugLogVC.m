//
//  DebugLogVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DebugLogVC.h"
#import "FXW_DebugView.h"

@interface DebugLogVC ()

@property (nonatomic, strong) FXW_DebugView             *debugView;

@property (nonatomic, strong) NSTimer                   *timer1;

@end

@implementation DebugLogVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"调试小工具";
    
    _debugView = [[FXW_DebugView alloc] initWithFrame:CGRectMake(0, screenHeight - 300, screenWidth, 300)];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer1 invalidate];
    
}

- (IBAction)clickBtnShowDebugView:(id)sender
{
    if (_timer1 == nil)
    {
        [_debugView fxw_show];
        
        WS(ws);
        _timer1 = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
            static int count = 0;
            NSString *msg = [NSString stringWithFormat:@"%s - %d", __func__,count++];
            [ws.debugView fxw_setMessage:msg];
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer1 forMode:NSRunLoopCommonModes];
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
