//
//  JSCallOCTWOVC.m
//  GYBase
//
//  Created by kenshin on 16/9/21.
//  Copyright © 2016年 kenshin. All rights reserved.
/*  
    学习 资源来自 http://www.jianshu.com/p/d19689e0ed83
 
     在iOS 7之后，apple添加了一个新的库JavaScriptCore，用来做JS交互，因此JS与原生OC交互也变得简单了许多。
     首先导入JavaScriptCore库, 然后在OC中获取JS的上下文
     
     再然后定义好JS需要调用的方法，例如JS要调用share方法：
     则可以在UIWebView加载url完成后，在其代理方法中添加要调用的share方法：
 */

#import "JSCallOCTWOVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCallOCTWOVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JSCallOCTWOVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JS 调用 OC";
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"jsCallOC2" ofType:@"html"];
    
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

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //定义好JS要调用的方法, share就是调用的share方法名
    //进入子线程
    context[@"share"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        NSLog(@"%@", [NSThread currentThread]);
        //回到主线程操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *content = [NSString stringWithFormat:@"%@", args];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"javaScriptCore" message:content delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
            [alertView show];
            NSLog(@"%@", [NSThread currentThread]);
        });
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
        
        NSLog(@"-------End Log-------");
    };
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
