//
//  BallVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/31.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "BallVC.h"
#import <CoreMotion/CoreMotion.h>
#import "BallView.h"

#define kUpdateInterval (1.0f/60.0f)

//注意！！！ 这里的nib中的vc中的self.view 是 BallView
@interface BallVC ()

@property (nonatomic, strong) CMMotionManager  *motionManager;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) BallView         *ballView;
@end

@implementation BallVC

//首先要禁用App界面方向 ：项目->Target->General->Deployment Info 取消除Portrait之外的所有方向
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"滚弹珠程序";
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
     ^(CMAccelerometerData *accelerometerData, NSError *error) {
         [(id)self.view setAcceleration:accelerometerData.acceleration];
         [self.view performSelectorOnMainThread:@selector(update)
                                     withObject:nil
                                  waitUntilDone:NO];
     }];
}




@end
