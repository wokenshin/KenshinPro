//
//  PureTableViewVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "PureTableViewVC.h"
#import "MFTextField.h"
#import "CtrlCountDown.h"

@interface PureTableViewVC ()
@property (nonatomic, strong) UITableView                   *tableView;

@property (nonatomic, strong) MFTextField               *txtPhoneNo;
@property (nonatomic, strong) MFTextField               *txtEmail;
@property (nonatomic, strong) MFTextField               *txtCheckNo;
@property (nonatomic, strong) MFTextField               *txtPassword;
@property (nonatomic, strong) MFTextField               *txtRePassword;

@property (nonatomic, strong) CtrlCountDown             *btnGetCheckNo;
@property (nonatomic, strong) MDButton                  *btnRegister;

@end

@implementation PureTableViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPureTableViewVCUI];
}

- (void)initPureTableViewVCUI
{
    self.navigationItem.title = @"纯代码TableView布局";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _tableView.backgroundColor = colorHomeBlue;
    _tableView.tableHeaderView = [self getMyHeaderView];
    [self.view addSubview:_tableView];
    
}

- (UIView *)getMyHeaderView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 700)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    //手机号
    _txtPhoneNo = [[MFTextField alloc] init];
    _txtPhoneNo.placeholderAnimatesOnFocus = YES;
    _txtPhoneNo.placeholder = @"请输入手机号码";
    _txtPhoneNo.keyboardType = UIKeyboardTypeNumberPad;
    
    [contentView addSubview:_txtPhoneNo];
    [_txtPhoneNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15*coefficient + 0);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(heightMText);
        
    }];
    
    //邮箱
    _txtEmail = [[MFTextField alloc] init];
    _txtEmail.placeholderAnimatesOnFocus = YES;
    _txtEmail.placeholder = @"请填写有效邮箱，用于找回密码";
    
    [contentView addSubview:_txtEmail];
    [_txtEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtPhoneNo.mas_bottom).offset(20*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(heightMText);
        
    }];
    
    //验证码
    _txtCheckNo = [[MFTextField alloc] init];
    _txtCheckNo.placeholderAnimatesOnFocus = YES;
    _txtCheckNo.placeholder = @"请输入验证码";
    _txtCheckNo.keyboardType = UIKeyboardTypeNumberPad;
    
    [contentView addSubview:_txtCheckNo];
    [_txtCheckNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtEmail.mas_bottom).offset(20*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient - 70*coefficient);//70:验证码按钮的长度
        make.height.mas_equalTo(heightMText);
        
    }];
    
    //获取验证码
    _btnGetCheckNo = [[CtrlCountDown alloc] initWithFrame:CGRectMake(0,0,0,0)
                                                     type:MDButtonTypeFlat
                                              rippleColor:[UIColor whiteColor]];
    _btnGetCheckNo.backgroundColor = colorHomeBlue;
    [_btnGetCheckNo setTitle:@"验证码" forState:UIControlStateNormal];
    [_btnGetCheckNo addTarget:self action:@selector(clickGetVerifyCoeBtn) forControlEvents:UIControlEventTouchUpInside];
    [_btnGetCheckNo setCountDownTime:60];
    
    [contentView addSubview:_btnGetCheckNo];
    [_btnGetCheckNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtEmail.mas_bottom).offset(30*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(36*coefficient);
        make.width.mas_equalTo(70*coefficient);
    }];
    
    //请输入密码
    _txtPassword = [[MFTextField alloc] init];
    _txtPassword.placeholderAnimatesOnFocus = YES;
    _txtPassword.placeholder = @"请输入登录密码";
    _txtPassword.secureTextEntry = YES;
    [contentView addSubview:_txtPassword];
    [_txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtCheckNo.mas_bottom).offset(20*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(heightMText);
        
    }];
    
    //请再次输入密码
    _txtRePassword = [[MFTextField alloc] init];
    _txtRePassword.placeholderAnimatesOnFocus = YES;
    _txtRePassword.placeholder = @"请再次输入登录密码";
    _txtRePassword.secureTextEntry = YES;
    [contentView addSubview:_txtRePassword];
    [_txtRePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtPassword.mas_bottom).offset(20*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(heightMText);
        
    }];
    
    //提交按钮
    _btnRegister = [[MDButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                              type:MDButtonTypeFlat rippleColor:[UIColor whiteColor]];
    _btnRegister.backgroundColor = colorHomeBlue;
    [_btnRegister setTitle:@"提交" forState:UIControlStateNormal];
    [_btnRegister addTarget:self action:@selector(clickRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_btnRegister];
    [_btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtRePassword.mas_bottom).offset(50*coefficient);
        make.left.mas_equalTo(40*coefficient);
        make.right.mas_equalTo(-40*coefficient);
        make.height.mas_equalTo(39*coefficient);
    }];
    
    //图片 手机
    UIImageView *imgPhone = [[UIImageView alloc] init];
    imgPhone.image = [UIImage imageNamed:@"login_phone"];
    [contentView addSubview:imgPhone];
    [imgPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtPhoneNo).offset(22);
        make.left.mas_equalTo(17);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(22);
    }];
    
    //图标 邮箱
    UIImageView *imgEmail = [[UIImageView alloc] init];
    imgEmail.image = [UIImage imageNamed:@"email"];
    [contentView addSubview:imgEmail];
    [imgEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtEmail).offset(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //图标 验证码
    UIImageView *imgVerify = [[UIImageView alloc] init];
    imgVerify.image = [UIImage imageNamed:@"verify"];
    [contentView addSubview:imgVerify];
    [imgVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtCheckNo).offset(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //图标 验证密码
    UIImageView *imgPwd = [[UIImageView alloc] init];
    imgPwd.image = [UIImage imageNamed:@"login_lock"];
    [contentView addSubview:imgPwd];
    [imgPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtPassword).offset(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    //图标 验证密码
    UIImageView *imgRePwd = [[UIImageView alloc] init];
    imgRePwd.image = [UIImage imageNamed:@"login_lock"];
    [contentView addSubview:imgRePwd];
    [imgRePwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_txtRePassword).offset(22);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];

    return contentView;
}

- (void)clickGetVerifyCoeBtn
{
    NSLog(@"clickGetVerifyCoeBtn");
}

- (void)clickRegisterBtn
{
    NSLog(@"clickRegisterBtn");
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
