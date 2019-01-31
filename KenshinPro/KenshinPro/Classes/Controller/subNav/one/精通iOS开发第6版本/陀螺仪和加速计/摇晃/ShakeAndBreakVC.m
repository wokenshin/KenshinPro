//
//  ShakeAndBreakVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/31.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "ShakeAndBreakVC.h"
#import <AVFoundation/AVFoundation.h>


@interface ShakeAndBreakVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) UIImage            *fixed;
@property (nonatomic, strong) UIImage            *broken;
@property (nonatomic, assign) BOOL               isBrokenScreenShowing;
@property (nonatomic, strong) AVAudioPlayer      *crashPlayer;

@end

@implementation ShakeAndBreakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"死劲儿摇晃手机";
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"glass" withExtension:@"wav"];
    NSError *err = nil;
    _crashPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    if (_crashPlayer == nil) {
        NSLog(@"Audio Error! %@", err.localizedDescription);
    }
    
    _fixed  = [UIImage imageNamed:@"home"];
    _broken = [UIImage imageNamed:@"homebroken"];
    _imgView.image = _fixed;
}

//在摇晃发生时被调用
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (_isBrokenScreenShowing == NO && motion == UIEventSubtypeMotionShake) {
        _imgView.image = _broken;
        [_crashPlayer play];
        _isBrokenScreenShowing = YES;
    }
}

//触摸时触发
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _imgView.image = _fixed;
    _isBrokenScreenShowing = NO;
}

@end
