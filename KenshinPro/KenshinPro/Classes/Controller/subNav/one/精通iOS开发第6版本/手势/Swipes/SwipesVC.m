//
//  SwipesVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/23.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "SwipesVC.h"

@interface SwipesVC ()

@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (nonatomic, assign) CGPoint gestureStartPoint;

@end

static CGFloat const kMinimumGestureLength = 25;
static CGFloat const kMaximunVariance      = 5;

@implementation SwipesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)eraseText{
    self.lab.text = @"";
}

#pragma mark - Touch Handing
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.gestureStartPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    
    CGFloat deltaX = fabs(self.gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabs(self.gestureStartPoint.y - currentPosition.y);
    
    if (deltaX >= kMinimumGestureLength && deltaY <= kMaximunVariance) {
        self.lab.text = @"Horizontal swipe detected";
        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
        
    } else if(deltaY >= kMinimumGestureLength && deltaX <= kMaximunVariance){
        self.lab.text = @"Vertical swipe detected";
        [self performSelector:@selector(eraseText) withObject:nil afterDelay:2];
    }
}
@end
