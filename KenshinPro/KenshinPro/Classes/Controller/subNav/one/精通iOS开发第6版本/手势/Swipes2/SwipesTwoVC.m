//
//  SwipesTwoVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/24.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "SwipesTwoVC.h"

@interface SwipesTwoVC ()
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (nonatomic, assign) BOOL  isMultipleTouch;
@end

@implementation SwipesTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势";
    //[self functionOne];
    
    //如果要使用上面注视的代码 就注视掉下面的代码
    _isMultipleTouch = YES;
    for (NSUInteger touchCount = 1; touchCount <= 5; touchCount ++) {
        [self functionOne];//这里循环了五次 就可以同时五指触摸
    }
    
    
}

- (void)functionOne{
    //添加手势 垂直方向滑动
    UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
    vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:vertical];
    
    //添加手势 水平方向滑动
    UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
    horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:horizontal];
}

- (void)eraseText{
    self.lab.text = @"";
}

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer{
    self.lab.text = @"Horizontal swipe detected";
    if (_isMultipleTouch) {
        self.lab.text = [NSString stringWithFormat:@"%@ Horizontal swipe detected", [self descriptionForTouchCount:[recognizer numberOfTouches]]];
    }
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer{
    self.lab.text = @"Vertical swipe detected";
    if (_isMultipleTouch) {
        self.lab.text = [NSString stringWithFormat:@"%@ Vertical swipe detected", [self descriptionForTouchCount:[recognizer numberOfTouches]]];
    }
    [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
}

- (NSString *)descriptionForTouchCount:(NSUInteger)touchCount{
    switch (touchCount) {
        case 1:
            return @"Single";
        case 2:
            return @"Double";
        case 3:
            return @"Triple";
        case 4:
            return @"Quadruple";
        case 5:
            return @"Quintuple";
        default:
            return @"";
    }
}

@end
