//
//  TextImgVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TextImgVC.h"
#import "FXW_TextImg.h"
#import "FXW_MDText.h"

@interface TextImgVC ()

@property (nonatomic, strong) UITextField           *text;
@property (nonatomic, strong) FXW_TextImg           *text2;
@property (nonatomic, strong) FXW_MDText            *textMd;

@end

@implementation TextImgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextImgVCUI];
    
}

- (void)initTextImgVCUI
{
    self.navigationItem.title = @"带图片的文本框";
    
    _text = [[UITextField alloc] init];
    _text.placeholder = @"我是系统文本框";
    
    //左视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView.image        = [UIImage imageNamed:@"yingmu_guilian"];
    _text.leftView       = imgView;
    _text.leftViewMode  = UITextFieldViewModeAlways;
    
    //右视图
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView2.image        = [UIImage imageNamed:@"yingmu_ok"];
    _text.rightView       = imgView2;
    _text.rightViewMode   = UITextFieldViewModeAlways;
    
    //添加手势事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(clickLeftView)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tapGesture];
    
    //添加手势
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(clickRightView)];
    imgView2.userInteractionEnabled = YES;
    [imgView2 addGestureRecognizer:tapGesture2];
    
    
    [self.view addSubview:_text];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(74);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(36);
    }];
    
    
    _text2 = [[FXW_TextImg alloc] init];
    _text2.placeholder = @"继承自系统的文本框";
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView3.image        = [UIImage imageNamed:@"yingmu_ok"];
    [_text2 fxw_setLeftImgView:imgView3];
    
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView4.image        = [UIImage imageNamed:@"yingmu_ok"];
    [_text2 fxw_setRightImgView:imgView4];
    
    [self.view addSubview:_text2];
    [_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_text.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(36);
    }];
    
    WS(ws);
    [_text2 fxw_clickLeftImg:^(FXW_TextImg *control) {
        [ws toast:@"click leftImg"];
    }];
    
    [_text2 fxw_clickRightImg:^(FXW_TextImg *control) {
        [ws toast:@"click rightImg"];
    }];
    
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView5.image        = [UIImage imageNamed:@"yingmu_ok"];
    
    _textMd = [[FXW_MDText alloc] init];
    _textMd.placeholder = @"我的MD风格文本框";
    [_textMd fxw_setLeftImgView:imgView5];
    
    [self.view addSubview:_textMd];
    [_textMd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_text2.mas_bottom).offset(30);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(36);
    }];
    
}

- (void)clickLeftView
{
    [self toast:@"click leftView"];
}

- (void)clickRightView
{
    [self toast:@"click rightView"];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
