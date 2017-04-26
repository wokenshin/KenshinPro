//
//  JSTWOVC.m
//  GYBase
//
//  Created by kenshin on 16/9/14.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
    页面打开的第一个网页是 call.html, 当点击 放大镜的时候 会调用一个js方法，5s后会跳转到另外一个网页 call2.html
 
    点击放大镜的时候 会调用js方法 并且 获取到js方法的返回值
 
 
    功能：OC调用js获取方法返回值
 */

#import "JSTWOVC.h"

@interface JSTWOVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView         *webView;

@end

@implementation JSTWOVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"OC调用JS";
    
    [self rightButton];
    self.webView.delegate = self;
    
    //加载本地html
    //找到call.html文件的路径
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"call.html"];
    NSURL *url = [NSURL fileURLWithPath:helpHtmlPath];
    //加载本地html文件
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:self.webView];
    
}

//右上角的按钮
- (void)rightButton
{
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                  target:self
                                  action:@selector(shareItemAction)];
    NSArray *arrBtns = @[shareItem];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
}

//按钮事件
- (void)shareItemAction
{
    //调用网页的js获取返回值[运用场景一：获取每个页面的url 用于分享]
    NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:@"fxw();"];
    NSLog(@"JS返回值：%@",str);
    [Tools toast:str andCuView:self.view];
    
    NSString *str2 = [self.webView stringByEvaluatingJavaScriptFromString:@"postStr();"];
    NSLog(@"JS返回值：%@",str2);
    [Tools toast:str2 andCuView:self.view andHeight:300];
    
}

#pragma mark 懒加载 webView
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        
    }
    return _webView;
    
}

#pragma mark UIWebViewDelegate


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
