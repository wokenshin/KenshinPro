//
//  SwitchModelVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SwitchModeVC.h"

@interface SwitchModeVC ()

/**
 背景
 */
@property (nonatomic, strong) UIImageView                   *backImg;

/**
 返回的按钮
 */
@property (nonatomic, strong) UIButton                      *backBtn;

/**
 顶部的标题
 */
@property (nonatomic, strong) UILabel                       *titleLab;

/**
 大圆图
 */
@property (nonatomic, strong) UIImageView                   *modeImgView;
@property (nonatomic, strong) UIImageView                   *lightCircleImgView;//光圈

/**
 办公室模式 & 家庭模式
 */
@property (nonatomic, strong) UIButton                      *btnOfficeMode;
@property (nonatomic, strong) UIButton                      *btnHomeMode;

/**
 蓝色箭头 指向 当前选择模式 原本想只使用一个箭头，但是更新约束的时候 出现bug，后面在优化吧
 */
@property (nonatomic, strong) UIImageView                   *arrowOffice;
@property (nonatomic, strong) UIImageView                   *arrowHome;

/**
 底部的提示文本
 */
@property (nonatomic, strong) UILabel                       *tipsLab;

@end

@implementation SwitchModeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSwitchModeUI];
    
}

- (void)initSwitchModeUI
{
    NSInteger fontTitle = 22;
    NSInteger fontBtn   = 20;
    NSInteger fontTips  = 15;
    
    //背景[根据当前模式 进行切换]
    _backImg = [[UIImageView alloc] init];
    _backImg.image = [UIImage imageNamed:@"back_homeMode"];
    [self.view addSubview:_backImg];
    [_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    //标题
    _titleLab = [[UILabel alloc] init];
    _titleLab.text = @"情景模式";
    _titleLab.font = FontK(fontTitle);
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*coefficient);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40*coefficient);
    }];
    
    //返回按钮
    _backBtn = [[UIButton alloc] init];
    [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setImage:[UIImage imageNamed:@"arrowMode"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*coefficient);
        make.left.mas_equalTo(10*coefficient);
        make.width.mas_equalTo(40*coefficient);
        make.height.mas_equalTo(40*coefficient);
    }];
    
    
    //圆图
    _modeImgView = [[UIImageView alloc] init];
    _modeImgView.image = [UIImage imageNamed:@"ic_mode_home"];
    [self.view addSubview:_modeImgView];
    [_modeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140*coefficient);
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(screenWidth*0.6*coefficient);
        make.height.mas_equalTo(screenWidth*0.6*coefficient);
    }];
    
    //蓝色光圈[只在家庭模式下显示，办公模式时隐藏]
    _lightCircleImgView = [[UIImageView alloc] init];
    _lightCircleImgView.image = [UIImage imageNamed:@"ic_modechange_wait"];
    [self.view addSubview:_lightCircleImgView];
    [_lightCircleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140*coefficient);
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(screenWidth*0.6*coefficient);
        make.height.mas_equalTo(screenWidth*0.6*coefficient);
    }];
    
    //办公模式按钮
    _btnOfficeMode = [[UIButton alloc] init];
    [_btnOfficeMode addTarget:self action:@selector(clickOfficeMode) forControlEvents:UIControlEventTouchUpInside];
    [_btnOfficeMode setTitle:@"办公室模式" forState:UIControlStateNormal];
    _btnOfficeMode.titleLabel.font = FontK(fontBtn);
    [self.view addSubview:_btnOfficeMode];
    [_btnOfficeMode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lightCircleImgView.mas_bottom).offset(50*coefficient);
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(120*coefficient);
        make.height.mas_equalTo(30*coefficient);
    }];
    
    //蓝色箭头
    _arrowOffice = [[UIImageView alloc] init];
    _arrowOffice.hidden = YES;
    _arrowOffice.image = [UIImage imageNamed:@"arrow_right"];
    [self.view addSubview:_arrowOffice];
    [_arrowOffice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnOfficeMode.mas_top).offset(6*coefficient);
        make.right.mas_equalTo(_btnOfficeMode.mas_left).offset(0);
        make.width.mas_equalTo(12*coefficient);
        make.height.mas_equalTo(20*coefficient);
    }];
    
    //家庭模式按钮
    _btnHomeMode = [[UIButton alloc] init];
    [_btnHomeMode addTarget:self action:@selector(clickHomeMode) forControlEvents:UIControlEventTouchUpInside];
    [_btnHomeMode setTitle:@"家庭模式" forState:UIControlStateNormal];
    _btnHomeMode.titleLabel.font = FontK(fontBtn);
    [_btnHomeMode setTitleColor:RGB2Color(15, 121, 211) forState:UIControlStateNormal];
    [self.view addSubview:_btnHomeMode];
    [_btnHomeMode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnOfficeMode.mas_bottom).offset(20*coefficient);
        make.centerX.mas_offset(0);
        make.width.mas_equalTo(120*coefficient);
        make.height.mas_equalTo(30*coefficient);
    }];
    
    //蓝色箭头
    _arrowHome = [[UIImageView alloc] init];
    _arrowHome.image = [UIImage imageNamed:@"arrow_right"];
    [self.view addSubview:_arrowHome];
    [_arrowHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnHomeMode.mas_top).offset(6*coefficient);
        make.right.mas_equalTo(_btnHomeMode.mas_left).offset(0);
        make.width.mas_equalTo(12*coefficient);
        make.height.mas_equalTo(20*coefficient);
    }];
    
    
    //提示文本
    _tipsLab = [[UILabel alloc] init];
    _tipsLab.numberOfLines = 0;
    _tipsLab.text = @"家庭模式已经激活，该模式下，锁打开8秒钟后会自动关闭";
    _tipsLab.textColor = [UIColor whiteColor];
    _tipsLab.font = FontK(fontTips);
    [self.view addSubview:_tipsLab];
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnHomeMode.mas_bottom).offset(40*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
    }];
    
}

#pragma mark 返回
- (void)clickBackBtn
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 办公室模式
- (void)clickOfficeMode
{
    NSLog(@"office");
    [_btnOfficeMode setTitleColor:RGB2Color(15, 121, 211) forState:UIControlStateNormal];
    [_btnHomeMode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _backImg.image = [UIImage imageNamed:@"back_officeMode"];
    _modeImgView.image = [UIImage imageNamed:@"ic_mode_office"];
    
    _arrowOffice.hidden = NO;
    _arrowHome.hidden = YES;
    _lightCircleImgView.hidden = YES;
    
    _tipsLab.text = @"办公室模式已经激活，该模式下，锁打开后处于常开状态，上提把手办公室模式自动解除";
    
}

#pragma mark 家庭模式
- (void)clickHomeMode
{
    NSLog(@"home");
    [_btnHomeMode setTitleColor:RGB2Color(15, 121, 211) forState:UIControlStateNormal];
    [_btnOfficeMode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _backImg.image = [UIImage imageNamed:@"back_homeMode"];
    _modeImgView.image = [UIImage imageNamed:@"ic_mode_home"];
    
    _arrowOffice.hidden = YES;
    _arrowHome.hidden = NO;
    _lightCircleImgView.hidden = NO;
    
    _tipsLab.text = @"家庭模式已经激活，该模式下，锁打开8秒钟后会自动关闭";
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
