//
//  OCCallJSTwoVC.m
//  GYBase
//
//  Created by kenshin on 16/9/21.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
     学习 资源来自 http://www.jianshu.com/p/d19689e0ed83

 
     JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
     NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
     [context evaluateScript:textJS];
    
     重点：
     stringByEvaluatingJavaScriptFromString是一个同步的方法，使用它执行JS方法时，如果JS 方法比较耗的时候，会造成界面卡顿。
     尤其是js 弹出alert 的时候。
 
     alert 也会阻塞界面，等待用户响应，而stringByEvaluatingJavaScriptFromString又会等待js执行完毕返回。这就造成了死锁。
     官方推荐使用WKWebView的evaluateJavaScript:completionHandler:代替这个方法。
     其实我们也有另外一种方式，自定义一个延迟执行alert 的方法来防止阻塞，然后我们调用自定义的alert 方法。
     同理，耗时较长的js 方法也可以放到setTimeout 中。
     
     function asyncAlert(content)
    {
        setTimeout(function()
        {
            alert(content);
        },1);
 
    }
 
 
 */

#import "OCCallJSTwoVC.h"
#import "Tools.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface OCCallJSTwoVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation OCCallJSTwoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"javaScriptCore";
    [self rightButton];
    
    //加载本地的html
    //加载本地html
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"ocCallJs" ofType:@"html"];
    
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    [self.view addSubview:self.webView];
    
}

#pragma mark 懒加载 webView
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    }
    return _webView;
    
}

- (void)rightButton
{
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                  target:self
                                  action:@selector(shareItemAction)];
    NSArray *arrBtns = @[shareItem];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
}

//调用js方法
- (void)shareItemAction
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
    [context evaluateScript:textJS];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
