//
//  OCToJSVC.m
//  GYBase
//
//  Created by kenshin on 16/9/21.
//  Copyright © 2016年 kenshin. All rights reserved.
//  学习 资源来自 http://www.jianshu.com/p/d19689e0ed83

#import "OCToJSVC.h"
#import "Tools.h"

@interface OCToJSVC ()

@property (nonatomic, strong) UIWebView     *webView;
@end

@implementation OCToJSVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"OC调用JS";
    [self rightButton];
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
    //在网页中有一个 叫 showAlert 的js方法
    NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"这里是JS中alert弹出的message"];
    /*NSString *asd = */ [_webView stringByEvaluatingJavaScriptFromString:jsStr];
    
    //注意：该方法会同步返回一个字符串，因此是一个同步方法，可能会阻塞UI。
    
}

#pragma mark 懒加载 webView
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    }
    return _webView;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
