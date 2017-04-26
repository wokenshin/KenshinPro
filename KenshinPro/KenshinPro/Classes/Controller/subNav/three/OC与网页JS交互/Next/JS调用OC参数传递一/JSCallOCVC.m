//
//  JSCallOCVC.m
//  GYBase
//
//  Created by kenshin on 16/9/21.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
    学习 资源来自 http://www.jianshu.com/p/d19689e0ed83
    
    功能：触发网页js，获取js中的内容【其实就是切割字符串。。。。沃日】
 
 
 */


#import "JSCallOCVC.h"
#import "Tools.h"

@interface JSCallOCVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView         *webView;
@end

@implementation JSCallOCVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JS调用OC";
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"jsCallOC" ofType:@"html"];
    
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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"firstclick"])
    {
        NSArray *params =[url.query componentsSeparatedByString:@"&"];
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params)
        {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1)
            {
                NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        
        NSString *cntent = [NSString stringWithFormat:@"%@", tempDic];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"JS调用OC-OC原生弹框" message:cntent delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"tempDic:%@",tempDic);
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end




















