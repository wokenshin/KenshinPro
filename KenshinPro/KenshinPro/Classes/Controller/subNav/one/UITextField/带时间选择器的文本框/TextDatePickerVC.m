//
//  TextDatePickerVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TextDatePickerVC.h"
#import "FXW_TextDatePicker.h"

@interface TextDatePickerVC ()

@property (nonatomic, strong) FXW_TextDatePicker            *txtDatePicker;

@end

@implementation TextDatePickerVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"文本框时间选择器";
    
    _txtDatePicker = [[FXW_TextDatePicker alloc] init];
    _txtDatePicker.placeholder = @"选择开始时间";
    _txtDatePicker.placeholderAnimatesOnFocus = YES;
    _txtDatePicker.keyboardType = UIKeyboardTypeNumberPad;
    _txtDatePicker.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_txtDatePicker];
    [_txtDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(heightMText);
    }];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
