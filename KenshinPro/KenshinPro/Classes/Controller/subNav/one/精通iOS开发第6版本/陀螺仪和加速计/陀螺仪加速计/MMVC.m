//
//  MMVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/31.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "MMVC.h"
#import <CoreMotion/CoreMotion.h>


@interface MMVC ()

@property (nonatomic, weak) IBOutlet UILabel *labAccelerometer;//加速计
@property (nonatomic, weak) IBOutlet UILabel *labGyroscope;//陀螺仪

@property (nonatomic, strong) CMMotionManager   *motionManager;
@property (nonatomic, strong) NSTimer           *updateTimer;

@end

@implementation MMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手动挡";
    
    _motionManager = [[CMMotionManager alloc] init];
    if (_motionManager.accelerometerAvailable) {
        _motionManager.accelerometerUpdateInterval = 1.0/10.0;
    } else {
        _labAccelerometer.text = @"This device has no accelerometer.";
    }
    if (_motionManager.gyroAvailable) {
        _motionManager.gyroUpdateInterval = 1.0/10.0;
    } else {
        _labGyroscope.text = @"This device has no gyroscope.";
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_motionManager startAccelerometerUpdates];
    [_motionManager startGyroUpdates];
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                    target:self
                                                  selector:@selector(updateDisplay)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_motionManager stopAccelerometerUpdates];
    [_motionManager stopGyroUpdates];
    [_updateTimer invalidate];
    _updateTimer = nil;
}

//per 0.1s doOnce
- (void)updateDisplay{
    if(_motionManager.accelerometerAvailable){
        CMAccelerometerData *data = _motionManager .accelerometerData;
        NSString *str = [NSString stringWithFormat:@"Accelerometer\n---\n"
                                  "x:%+.2f\ny:%+.2f\nz:%+.2f",
                                  data.acceleration.x,
                                  data.acceleration.y,
                                  data.acceleration.z];
        _labAccelerometer.text = str;
        
    }
    if (_motionManager.gyroAvailable) {
        CMGyroData *data = _motionManager.gyroData;
        NSString *str = [NSString stringWithFormat:@"Gyroscope\n---\n"
                              "x:%+.2f\ny:%+.2f\nz:%+.2f",
                              data.rotationRate.x,
                              data.rotationRate.y,
                              data.rotationRate.z];
        _labGyroscope.text = str;
    }
}


@end
