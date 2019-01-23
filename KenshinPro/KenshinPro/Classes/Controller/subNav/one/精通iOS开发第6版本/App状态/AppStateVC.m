//
//  AppStateVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "AppStateVC.h"

static NSString *AppState_SegmengCtrlIndex = @"AppState_SegmengCtrlIndex";

@interface AppStateVC ()

@property (nonatomic, strong) UILabel   *lab;
@property (nonatomic, assign) BOOL      isAnimate;

@property (nonatomic, strong) UIImage   *img;
@property (nonatomic, strong) UIImageView   *imgView;

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@end

@implementation AppStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //标签
    CGRect bounds = self.view.bounds;
    CGRect labFrame = CGRectMake(bounds.origin.x, CGRectGetMidY(bounds) - 50, bounds.size.width, 100);
    _lab = [[UILabel alloc] initWithFrame:labFrame];
    _lab.font = [UIFont fontWithName:@"Helvetica" size:70];
    _lab.text = @"Kenshin!";
    _lab.textAlignment = NSTextAlignmentCenter;
    _lab.backgroundColor = [UIColor clearColor];
    
    //图片
    CGRect bjFrame = CGRectMake(CGRectGetMidX(bounds) - 42, CGRectGetMidY(bounds)/2 - 20, 100, 200);
    _imgView = [[UIImageView alloc] initWithFrame:bjFrame];
    NSString *pathImg = [[NSBundle mainBundle] pathForResource:@"wlp" ofType:@"jpg"];
    _img = [UIImage imageWithContentsOfFile:pathImg];
    _imgView.image = _img;
    
    //分段选择
    _segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"One",@"Two",@"Three",@"Four"]];
    _segmentCtrl.frame = CGRectMake(bounds.origin.x + 20, 84, bounds.size.width - 40, 30);
    
    //如果先前有保存值，就设置值
    NSNumber *indexNumber = [[NSUserDefaults standardUserDefaults] objectForKey:AppState_SegmengCtrlIndex];
    if (indexNumber) {
        NSInteger selectedIndex = [indexNumber intValue];
        _segmentCtrl.selectedSegmentIndex = selectedIndex;
    }
    
    [self.view addSubview:_segmentCtrl];
    [self.view addSubview:_imgView];
    [self.view addSubview:_lab];
    
    [self rotateLabelDown];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(applicationWillResignActive)
                   name:UIApplicationWillResignActiveNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(applicationDidBecomeActive)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(applicationDidEnterBackground)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(applicationWillEnterForeground)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
}

- (void)applicationWillResignActive{
    NSLog(@"VC:%@", NSStringFromSelector(_cmd));
    _isAnimate = NO;
}

- (void)applicationDidBecomeActive{
    NSLog(@"VC:%@", NSStringFromSelector(_cmd));
    _isAnimate = YES;
    [self rotateLabelDown];
}

- (void)applicationDidEnterBackground{
    NSLog(@"VC:%@", NSStringFromSelector(_cmd));
    
    
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier taskId;
    
    //调用 beginBackgroundTaskWithExpirationHandler 目的是告诉系统 我们需要更多时间来完成某件事
    taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background task run out of time and was terminated");
        [app endBackgroundTask:taskId];
    }];
    
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"Faild to start background task!");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _img = nil;
        _imgView = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Starting background task with %f seconds remaining", app.backgroundTimeRemaining);
            NSInteger selectedIndex = _segmentCtrl.selectedSegmentIndex;
            [[NSUserDefaults standardUserDefaults] setInteger:selectedIndex forKey:AppState_SegmengCtrlIndex];
        });
        
        
        
        //模拟一个25s的过程
        [NSThread sleepForTimeInterval:25];
        NSLog(@"Finishing background task with %f seconds remaining", app.backgroundTimeRemaining);
        [app endBackgroundTask:taskId];
    });
}

- (void)applicationWillEnterForeground{
    NSLog(@"VC:%@", NSStringFromSelector(_cmd));
    NSString *pathImg = [[NSBundle mainBundle] pathForResource:@"wlp" ofType:@"jpg"];
    _img = [UIImage imageWithContentsOfFile:pathImg];
    _imgView.image = _img;
    
    NSInteger selectedIndex = self.segmentCtrl.selectedSegmentIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedIndex forKey:AppState_SegmengCtrlIndex];
}

- (void)rotateLabelDown{
    [UIView animateWithDuration:0.5 animations:^{
        _lab.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [self rotateLabelUp];
    }];
}

-
(void)rotateLabelUp{
    [UIView animateWithDuration:0.5 animations:^{
        _lab.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        if (_isAnimate) {
            [self rotateLabelDown];
        }
    }];
}
@end
