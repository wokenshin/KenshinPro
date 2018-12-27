//
//  SwitchViewVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "SwitchViewVC.h"
#import "YellowVC.h"
#import "BlueVC.h"

@interface SwitchViewVC ()

@property (nonatomic, strong) YellowVC *yellowVC;
@property (nonatomic, strong) BlueVC   *blueVC;

@end

@implementation SwitchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"page 125";
    _blueVC = [[BlueVC alloc] init];
    [self.view insertSubview:_blueVC.view atIndex:0];
}

- (IBAction)switchViews:(id)sender {
    
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //如果该视图没有父视图则释放它
    
    //判断黄vc的view是否有父视图，就是判断当前是否现实的是黄vc
    //如果 == nil，说明当前没有现实黄vc，所以就让当前现实黄vc
    if (_yellowVC.view.superview == nil) {
        
        if (_yellowVC == nil) {
            _yellowVC = [[YellowVC alloc] init];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [_blueVC.view removeFromSuperview];
        [self.view insertSubview:_yellowVC.view atIndex:0];
    }
    else{
        if (_blueVC.view.superview == nil) {//同理
            if (_blueVC == nil) {
                _blueVC = [[BlueVC alloc] init];
            }
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [_yellowVC.view removeFromSuperview];
        [self.view insertSubview:_blueVC.view atIndex:0];
    }
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //释放没用到的缓存数据、图片等
    _blueVC = nil;
    _yellowVC = nil;
}

@end
