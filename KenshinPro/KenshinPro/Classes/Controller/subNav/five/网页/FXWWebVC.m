//
//  FXWWebVC.m
//  KenshinPro
//
//  Created by apple on 2018/8/8.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FXWWebVC.h"


@interface FXWWebVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView                 *webView;
@property (nonatomic, strong) UIActivityIndicatorView   *juHua;


@end

@implementation FXWWebVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //添加右上角返回上一级网页的按钮
    UIButton *rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 80, 44);
    
    //事件
    [rightBtn addTarget:self action:@selector(clickRightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
}

#pragma mark 上一页
- (void)clickRightNavBtn{
    
    if (_webView.canGoBack) {
        [_webView goBack];
    }
    else{
        NSLog(@">>> 当前已是第一页，不可返回");
    }
    
}

#pragma mark 加载指定的网页
- (void)loadUrl:(NSString *)url{
    
    //需要判断一下网址是否合法
    
    //初始化网页视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _juHua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juHua.center = self.view.center;
    _juHua.hidesWhenStopped = YES;
    
    //加载网页
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    [_webView addSubview:_juHua];
    
}


#pragma mark - webview
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@">>> webViewDidFinishLoad");
    [self.juHua stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@">>> didFailLoadWithError: %@", error);
    [self.juHua stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@">>> webViewDidStartLoad");
    
    //加载标题
    NSString *theTitle = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle) {
        self.title = theTitle;
    }
    
    [self.juHua startAnimating];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@">>> shouldStartLoadWithRequest");
    if (UIWebViewNavigationTypeFormSubmitted == navigationType) {
        return YES;
    }
    return YES;
}



- (void)dealloc
{
    NSLog(@"——————————————%s Destroy!!!——————————————————————————————", object_getClassName(self));
}

@end
