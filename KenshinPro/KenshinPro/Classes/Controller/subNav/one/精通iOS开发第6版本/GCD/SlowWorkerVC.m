//
//  SlowWorkerVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/17.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "SlowWorkerVC.h"

@interface SlowWorkerVC ()
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *juHua;

@end

@implementation SlowWorkerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 卡顿10s
- (IBAction)clickBtn:(id)sender {
    
    _txtView.text = @"当你点击按钮的时候，页面会被挂起10秒钟，然后才会恢复。";
    
    NSDate *startTime = [NSDate date];
    NSString *fetchedData = [self fetchSomethingFromServer];
    NSString *processData = [self processData:fetchedData];
    NSString *firstResult = [self calculateFirstResult:processData];
    NSString *secondResult = [self calculateSecondResult:processData];
    NSString *resultsSummary = [NSString stringWithFormat:@"First:[%@]\nSecond:[%@]", firstResult, secondResult];
    self.txtView.text = resultsSummary;
    NSDate *endTime = [NSDate date];
    NSLog(@"Complete in %f seconds", [endTime timeIntervalSinceDate:startTime]);
    
}

- (NSString *)fetchSomethingFromServer{
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data{
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data{
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"number of chars: %lu", (unsigned long)[data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data{
    [NSThread sleepForTimeInterval:4];
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

#pragma mark - 后台 串行执行
- (IBAction)clickBtn2:(id)sender {
    
    //后台执行
    _txtView.text = @"后台执行，UI不会卡住";
    _btn2.enabled = NO;
    [_juHua startAnimating];
    //为什么这里date的代码要放在block外面？
    //本方法在执行的时候，block被调用后，本方法就结束了，此时 startTime也就被释放了
    //但是由于block的存在，block内部使用了startTime，所以这里的startTime会被retain
    //之后 block内部就可以访问到startTime了
    NSDate *startTime = [NSDate date];
    
    //参数一：优先级，参数二：目前未使用 所以为 0
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processData = [self processData:fetchedData];
        NSString *firstResult = [self calculateFirstResult:processData];
        NSString *secondResult = [self calculateSecondResult:processData];
        NSString *resultsSummary = [NSString stringWithFormat:@"First:[%@]\nSecond:[%@]", firstResult, secondResult];
        
        //回到主线程队列
        dispatch_async(dispatch_get_main_queue(), ^{
            _txtView.text = resultsSummary;
            _btn2.enabled = YES;
            [_juHua stopAnimating];
        });
        
        NSDate *endTime = [NSDate date];
        NSLog(@"Complete in %f seconds", [endTime timeIntervalSinceDate:startTime]);
    });
    
}

#pragma mark - 后台 并发执行
- (IBAction)clickBtn3:(id)sender {
    //后台执行
    _txtView.text = @"后台执行，UI不会卡住";
    _btn3.enabled = NO;
    _btn3.alpha   = 0.5f;
    [_juHua startAnimating];
    
    NSDate *startTime = [NSDate date];
    
    //参数一：优先级，参数二：目前未使用 所以为 0
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processData = [self processData:fetchedData];
        
        __block NSString *first;
        __block NSString *second;
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, queue, ^{
            first = [self calculateFirstResult:processData];
        });
        
        dispatch_group_async(group, queue, ^{
            second = [self calculateSecondResult:processData];
        });
        
        dispatch_group_notify(group, queue, ^{
            NSString *resultS = [NSString stringWithFormat:@"First:[%@]\nSecond:[%@]", first, second];
            
            //回到主线程队列
            dispatch_async(dispatch_get_main_queue(), ^{
                _txtView.text = resultS;
                _btn3.enabled = YES;
                _btn3.alpha   = 0;
                [_juHua stopAnimating];
            });
            
            NSDate *endTime = [NSDate date];
            NSLog(@"Complete in %f seconds", [endTime timeIntervalSinceDate:startTime]);
        });
        
    });
}

@end
