//
//  UITextViewBaseVC.m
//  KenshinPro
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "UITextViewBaseVC.h"

@interface UITextViewBaseVC ()

@property (strong, nonatomic) UITextView *txtView;
@property (strong, nonatomic) UIButton   *btnBackDel;

@end

@implementation UITextViewBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"回删";
    
    _txtView    = [[UITextView alloc] initWithFrame:CGRectMake(10, 74, screenWidth - 10, 36)];
    _txtView.backgroundColor = [UIColor yellowColor];
    
    _btnBackDel = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 50, 120, 40, 36)];
    [_btnBackDel setTitle:@"删除" forState:UIControlStateNormal];
    _btnBackDel.backgroundColor = [UIColor blueColor];
    [_btnBackDel addTarget:self action:@selector(clickBtnBackDelete) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_txtView];
    [self.view addSubview:_btnBackDel];
    
}

#pragma mark 删除最后一个字符串
- (void)clickBtnBackDelete
{
    [_txtView deleteBackward];
}


@end
