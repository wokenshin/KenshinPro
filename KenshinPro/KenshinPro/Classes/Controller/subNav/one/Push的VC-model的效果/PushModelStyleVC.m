//
//  PushModelStyleVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "PushModelStyleVC.h"

@interface PushModelStyleVC ()

@property (nonatomic, strong) FXW_Button            *btn;

@end

@implementation PushModelStyleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"push过来的";
    _btn = [[FXW_Button alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_btn];
    
    WS(ws);
    [_btn clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws fxwPop];
    }];
    
    
}

//model样式的pop
- (void)fxwPop
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
