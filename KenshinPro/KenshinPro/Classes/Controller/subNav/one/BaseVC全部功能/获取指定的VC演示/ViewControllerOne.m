//
//  ViewControllerOne.m
//  KenshinPro
//
//  Created by kenshin on 17/3/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"

@interface ViewControllerOne ()

@property (nonatomic, strong) FXW_Button                    *btnPush;

@end

@implementation ViewControllerOne

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"第一个VC";
    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, screenWidth - 60, 36)];
    _lab.backgroundColor = [UIColor orangeColor];
    _lab.text = @"接收pop传至";
    
    _btnPush = [[FXW_Button alloc] initWithFrame:CGRectMake(30, 156, screenWidth - 60, 36)];
    _btnPush.backgroundColor = colorDdzmBlueBtn;
    [_btnPush setTitle:@"push" forState:UIControlStateNormal];
    
    [self.view addSubview:_lab];
    [self.view addSubview:_btnPush];
    
    WS(ws);
    [_btnPush clickButtonWithResultBlock:^(FXW_Button *button) {
        ViewControllerTwo *vc = [[ViewControllerTwo alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
