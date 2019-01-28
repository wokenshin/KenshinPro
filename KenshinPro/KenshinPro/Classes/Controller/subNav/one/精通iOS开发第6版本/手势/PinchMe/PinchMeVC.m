//
//  PinchMeVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/28.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "PinchMeVC.h"

@interface PinchMeVC ()

@property (nonatomic, strong) UIImageView   *imgView;


@property (nonatomic, assign) CGFloat       scale;//当前缩放比例
@property (nonatomic, assign) CGFloat       previousScale;//先前缩放比例

@property (nonatomic, assign) CGFloat       rotation;//当前旋转角度
@property (nonatomic, assign) CGFloat       previousRotation;//先前旋转角度

@end

@implementation PinchMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _previousScale = 1;
    
    //UI
    UIImage *img = [UIImage imageNamed:@"bjqs"];
    _imgView = [[UIImageView alloc] initWithImage:img];
    _imgView.userInteractionEnabled = YES;
    _imgView.center = self.view.center;
    [self.view addSubview:_imgView];
    
    //手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(doPinch:)];
    pinchGesture.delegate = self;
    [_imgView addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(doRotate:)];
    rotationGesture.delegate = self;
    [_imgView addGestureRecognizer:rotationGesture];
    
    
}

//始终返回YES 目的是 让缩放手势 和 旋转手势 同时工作[否则 先开始的手势会屏蔽掉另一个手势]
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)transformImageView{
    CGAffineTransform t = CGAffineTransformMakeScale(_scale * _previousScale, _scale * _previousScale);
    t = CGAffineTransformRotate(t, _rotation + _previousRotation);
    _imgView.transform = t;
}

- (void)doPinch:(UIPinchGestureRecognizer *)gesture{
    _scale = gesture.scale;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {//if 手势结束
        _previousScale = _scale * _previousScale;
        _scale = 1;
    }
}

- (void)doRotate:(UIRotationGestureRecognizer *)gesture{
    _rotation = gesture.rotation;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {//if 手势结束
        _previousRotation = _rotation + _previousRotation;
        _rotation = 0;
    }
}
@end
