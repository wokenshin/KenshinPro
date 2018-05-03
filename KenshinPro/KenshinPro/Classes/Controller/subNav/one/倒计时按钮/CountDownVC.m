//
//  CountDownVC.m
//  KenshinPro
//
//  Created by kenshin on 17/5/17.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CountDownVC.h"
#import "FXW_CountDownButton.h"

@interface CountDownVC ()

@property (weak, nonatomic) IBOutlet UIButton   *btnCountDown;

//倒计时
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, assign) NSTimeInterval    timeNum;//60s

@property (nonatomic, assign) NSTimeInterval    backTime;//后台时间
@property (nonatomic, assign) NSTimeInterval    forgTime;//前台时间
@property (nonatomic, assign) NSTimeInterval    remberTime;//保存定时器进入后台时的时间

//封装好的倒计时按钮
@property (nonatomic, strong) FXW_CountDownButton   *btn;
@end

@implementation CountDownVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"倒计时按钮";
    
    //接收App进入前台时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (appEnterForeground) name: UIApplicationWillEnterForegroundNotification object:nil];
    
    //接收App进入后台时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (appEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    _btn = [[FXW_CountDownButton alloc] initWithFrame:CGRectMake(30, 350, screenWidth - 60, 36)];
    _btn.countDownSecond = 60;
    _btn.backgroundColor = colorHomeBlue;
    [self.view addSubview:_btn];
    [_btn setTitle:@"封装倒计时按钮" forState:UIControlStateNormal];
    
    [_btn clickButtonWithResultBlock:^(BOOL isStartCounting, BOOL isCounting) {
        if (isStartCounting)
        {
            NSLog(@"开始倒计时");
        }
        else if(isCounting)
        {
            NSLog(@"正在倒计时");
        }
        
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIApplicationDidEnterBackgroundNotification object:nil];
    
    //不用调用 invalidate 倒计时为0的时候就会触发 因为我的方法里面已经调用invalidate了
//    [_timer invalidate];
//    _timer = nil;
    
//    [_btn cleanTimer];
    
}

#pragma mark 点击倒计时按钮
- (IBAction)clickButtonCountDown:(id)sender
{
    if (_timeNum <= 0)
    {
        [self startCountDown];
    }
    else//如果还在倒计时则不执行新的倒计时
    {
        [self toast:@"倒计时还在继续。。。"];
    }
    
    
}

#pragma mark 开始倒计时
- (void)startCountDown
{
    //网络请求，请求成功后 开始倒计时
    _timeNum = 60;//设置默认倒计时时间为60s
    if (_timer == nil)//设置倒计时
    {
        //每间隔1s会去执行一次countDown
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    
    [_btnCountDown setTitle:@"还剩60秒" forState:UIControlStateNormal];
    
}

#pragma mark 倒计时_周期调用 <=0时 停止倒计时 并恢复默认样式
- (void)countDown
{
    _timeNum--;
    
    [_btnCountDown setTitle:[NSString stringWithFormat:@"还剩%d秒", (int)_timeNum] forState:UIControlStateNormal];
    
    if (_timeNum <= 0)
    {
        
        [_btnCountDown setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        _timeNum = 60;
        
        [_timer invalidate];
        _timer = nil;
        
    }
    
}

#pragma mark App进入后台
- (void)appEnterBackground
{
    NSLog(@"app 进入后台");
    
    //记录进入后台时的时间
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    _backTime = time;
    
    _remberTime = _timeNum;//将定时器的时间保存起来 因为进入后台的时候 定时器的时间还在逐渐减少
    
}

#pragma mark App进入前台[能够触发函数的前提是:App之前就进入后台了]
- (void)appEnterForeground
{
    NSLog(@"app 进如前台");
    if (_timer == nil)
    {
        return;
    }
    
    //记录进入前台时的时间
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    _forgTime = time;
    
    //时间差 大 - 小
    NSTimeInterval timeCha = _forgTime - _backTime;
    _timeNum = _remberTime;//将定时器进入后台时的时间赋值给倒计时时间 [因为进入后台的时候 定时器的时间还在逐渐减少]
    
    NSLog(@">>>定时器时间：%f", _timeNum);
    NSLog(@">>>进入后台时：%f", _backTime);
    NSLog(@">>>进入前台时：%f", _forgTime);
    NSLog(@">>>时间差   ：%f", timeCha);
    
    _timeNum = _timeNum - timeCha;
    
    
    NSLog(@">>>显示的时间:%f", _timeNum);
    
    //将保存的时间清零 可能再次切换 前后台
    _forgTime = 0;
    _backTime = 0;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}



@end
