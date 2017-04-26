//
//  MCSearchVC.m
//  GYBase
//
//  Created by kenshin on 16/9/7.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "MCSearchVC.h"

@interface MCSearchVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField           *textSearch;

@end

@implementation MCSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self hideBackButton];
    [self setNavSearchView];
    [self setRightNavButton];
    [_textSearch becomeFirstResponder];
    
}

#pragma mark 隐藏返回按钮
- (void)hideBackButton
{
    //思路：设置一个自定义的左边的按钮来实现：相当于自定义了一个按钮 然后又将这个按钮像左移动了50个像素
    
    //箭头按钮
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowBtn setTitle:@"" forState:UIControlStateNormal];
    [arrowBtn sizeToFit];
    
    
    UIBarButtonItem *arrowItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBtn];
    

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -50;
    
    //将按钮添加到导航条上
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, arrowItem, nil];

    
}

#pragma mark 自定义搜索栏
- (void)setNavSearchView
{
    //搜索[UIView + imageview + text]
    CGFloat xSearchView = 5;
    CGFloat ySearchView = 27;
    CGFloat wSearchView = screenWidth - xSearchView - 10 - 39;
    CGFloat hSearchView = 30;
    
    UIControl *searchCtrl = [[UIControl alloc] initWithFrame:CGRectMake(xSearchView, ySearchView, wSearchView, hSearchView)];
    [searchCtrl addTarget:self action:@selector(searchActive) forControlEvents:UIControlEventTouchUpInside];
    searchCtrl.backgroundColor = colorGraySearch;
    [Tools setCornerRadiusWithView:searchCtrl andAngle:30/2];
    //边框
    [Tools setBorder:searchCtrl andColor:colorGraySearch andWeight:0.5];
    
    //放大镜
    UIImageView *fdjView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
    fdjView.image = [UIImage imageNamed:@"search_fdj"];
    [searchCtrl addSubview:fdjView];
    
    //提示文本
    CGFloat xP = CGRectGetMaxX(fdjView.frame) + 5;
    CGFloat wP = wSearchView - 40;
    _textSearch = [[UITextField alloc] initWithFrame:CGRectMake(xP, 0, wP, hSearchView)];
    _textSearch.placeholder = @"搜索大神或服务";
    _textSearch.font = FontSearch;
    _textSearch.textColor = [UIColor blackColor];
    _textSearch.clearButtonMode = UITextFieldViewModeAlways;
    _textSearch.returnKeyType = UIReturnKeySearch;
    _textSearch.delegate = self;
    _textSearch.tintColor = [UIColor redColor];//设置光标的颜色 这里如果不设置光标的颜色的话 默认他会和返回按钮文本的颜色一样 那就是白色 所以不好看
    [searchCtrl addSubview:_textSearch];
    
    self.navigationItem.titleView = searchCtrl;
    
}

#pragma mark 自定义导航栏按钮  右按钮
- (void)setRightNavButton
{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB2Color(254, 92, 91) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn sizeToFit];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    /**
     width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    
    //将按钮添加到导航条上
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, cancelItem, nil];

}

- (void)searchActive
{
    [_textSearch becomeFirstResponder];
    
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)closeKeyBoardWhenTouchBackView
{
    [_textSearch resignFirstResponder];
    
}

#pragma mark 文本框代理 监听软键盘的搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSLog(@"%@", textField.text);
    return YES;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
