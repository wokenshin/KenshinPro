//
//  MotionMonitorVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/30.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "MotionMonitorVC.h"
#import <CoreMotion/CoreMotion.h>

@interface MotionMonitorVC ()

@property (nonatomic, weak) IBOutlet UILabel *labAccelerometer;//加速计
@property (nonatomic, weak) IBOutlet UILabel *labGyroscope;//陀螺仪

@property (nonatomic, strong) CMMotionManager   *motionManager;
@property (nonatomic, strong) NSOperationQueue  *queue;

@end

@implementation MotionMonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自动挡";
    _motionManager = [[CMMotionManager alloc] init];
    _queue = [[NSOperationQueue alloc] init];
    
    if (_motionManager.accelerometerAvailable) {
        _motionManager.accelerometerUpdateInterval = 1.0/10.0;
        [_motionManager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSString *labelText;
            if (error) {
                [_motionManager stopAccelerometerUpdates];
                labelText = [NSString stringWithFormat:@"Accelerometer encountered error:%@", error];
            } else {
                labelText = [NSString stringWithFormat:@"Acceleremoter\n---\n"
                             "x:%+.2f\ny:%+.2f\nz:%+.2f",
                             accelerometerData.acceleration.x,
                             accelerometerData.acceleration.y,
                             accelerometerData.acceleration.z];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _labAccelerometer.text = labelText;
            });
        }];
    } else {
        _labAccelerometer.text = @"This device has no accelerometer.";
    }
    
    if (_motionManager.gyroAvailable) {
        _motionManager.gyroUpdateInterval = 1.0/10.0;
        [_motionManager startGyroUpdatesToQueue:_queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSString *labelText;
            if (error) {
                [_motionManager stopGyroUpdates];
                labelText = [NSString stringWithFormat:@"Gyroscope encountered error:%@", error];
            } else {
                labelText = [NSString stringWithFormat:@"Gyroscope\n---\n"
                             "x:%+.2f\ny:%+.2f\nz:%+.2f",
                             gyroData.rotationRate.x,
                             gyroData.rotationRate.y,
                             gyroData.rotationRate.z];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _labGyroscope.text = labelText;
            });
        }];
    } else {
        _labGyroscope.text = @"This device has no gyroscope";
    }
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}



@end
