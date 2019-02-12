//
//  PasswordInpudWindow.m
//  KenshinPro
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "PasswordInpudWindow.h"

@interface PasswordInpudWindow ()

@property (nonatomic, strong) UITextField   *textField;

@end

@implementation PasswordInpudWindow

+ (PasswordInpudWindow *)shareInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = 200;
        CGFloat height = 36;
        CGFloat x = screenWidth/2 - width/2;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, 120, width, height)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.secureTextEntry = YES;
        _textField.placeholder = @"请输入密码";
        [self addSubview:_textField];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 160, width, height)];
        [btn setBackgroundColor:[UIColor blueColor]];
        btn.titleLabel.textColor = [UIColor blackColor];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(completeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


/**
 注意：
 如果我们创建的UIWindow需要处理键盘事件，那么j就需要合理地讲其设置为keyWindow。因为keyWindow是被系统设计用来接收键盘事件和
 其他非触摸事件的UIWindow。我们可以通过makeKeyWindow和resignKeyWindow方法来讲自己创建的UIWindow实例设置成keyWindow
 */
- (void)show{
    [self makeKeyWindow];//这行代码很重要
    self.hidden = NO;
}

- (void)completeButtonPressed:(UIButton *)sender{
    if ([_textField.text isEqualToString:@"admin"]) {
        [_textField resignFirstResponder];
        [self resignKeyWindow];//这行代码很重要
        self.hidden = YES;
    } else {
        [self showErrorAlertView];
    }
}

- (void)showErrorAlertView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"密码错误，正确密码是admin"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
