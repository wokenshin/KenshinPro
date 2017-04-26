//
//  JSONEVC.m
//  GYBase
//
//  Created by kenshin on 16/9/14.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "JSONEVC.h"

@interface JSONEVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView     *webView;

@end

@implementation JSONEVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"加载本地网页";
    
    //通过下面的方法加载本地的html 这个html关联了一个js 和 css文件
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    
    //在写html的时候 里面的js的文件名我之前写错了，结果怎么弄都没找出原因 还是放在浏览器中才测出来的，真他么傻逼！
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
    
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    self.webView.delegate = self;
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

#pragma mark UIWebViewDelegate
//开始加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    NSString* urlstring = [NSString stringWithFormat:@"%@",url];
    NSLog(@"url = >%@",urlstring);
    
    return YES;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
