//
//  MCNavBarVC.m
//  GYBase
//
//  Created by kenshin on 16/9/7.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
 通过自定义导航栏实现一个类似美团搜索栏的样式；
 先前的项目是通过隐藏导航栏后，自己一view来实现的（这样做有bug，虽然优化了，但是还是很不优雅）。下面是自定义导航栏来实现。
 
 今后都采用自定义导航栏的形式来实现
 
 */

#import "MCNavBarVC.h"
#import "MCSearchVC.h"

@interface MCNavBarVC ()

@end

@implementation MCNavBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLeftNavButton];
    [self setRightNavButton];
    [self setNavSearchView];
}

#pragma mark 自定义导航栏按钮  左按钮
- (void)setLeftNavButton
{
    //用于移动一段距离
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    
    //城市按钮
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn setTitle:@"贵阳" forState:UIControlStateNormal];
    [cityBtn setTitleColor:RGB2Color(254, 92, 91) forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [cityBtn sizeToFit];
    
    //箭头按钮
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowBtn setImage:[UIImage imageNamed:@"selectCity"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [arrowBtn sizeToFit];
    
    
    UIBarButtonItem *cityItem  = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    UIBarButtonItem *arrowItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBtn];
    
    //将按钮添加到导航条上
    self.navigationItem.leftBarButtonItems  = @[negativeSpacer, cityItem, arrowItem];
    
}

#pragma mark 自定义导航栏按钮  右按钮
- (void)setRightNavButton
{
    //消息按钮
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [msgBtn setImage:[UIImage imageNamed:@"msg"] forState:UIControlStateNormal];
    [msgBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [msgBtn sizeToFit];
    
    UIBarButtonItem *msgItem = [[UIBarButtonItem alloc] initWithCustomView:msgBtn];
    
    /**
     width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    
    //将按钮添加到导航条上
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, msgItem, nil];
    
    
    
    
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
    [searchCtrl addTarget:self action:@selector(junpSearchServerVC) forControlEvents:UIControlEventTouchUpInside];
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
    UILabel *placeLab = [[UILabel alloc] initWithFrame:CGRectMake(xP, 0, wP, hSearchView)];
    placeLab.text = @"搜索大神或服务";
    placeLab.font = FontSearch;
    
    placeLab.textColor = colorGraySearch;
    [searchCtrl addSubview:placeLab];
    
    self.navigationItem.titleView = searchCtrl;
    
}

//选择城市
- (void)selectCity
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//跳转到搜索界面
- (void)junpSearchServerVC
{
    MCSearchVC *vc = [MCSearchVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
