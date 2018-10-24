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
@property (nonatomic, strong) UIButton                  *btnNextPage;

@end

@implementation FXWWebVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //添加右上角返回上一级网页的按钮
    _btnNextPage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btnNextPage setTitle:@"上一页" forState:UIControlStateNormal];
    [_btnNextPage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnNextPage.frame = CGRectMake(0, 0, 80, 44);
    
    //事件
    [_btnNextPage addTarget:self action:@selector(clickRightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_btnNextPage];
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

- (void)initWebVC{
    
    //初始化网页视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //菊花
    _juHua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juHua.center = self.view.center;
    _juHua.hidesWhenStopped = YES;
    [_webView addSubview:_juHua];
}

#pragma mark - [接口]加载指定的网页
- (void)loadUrl:(NSString *)url{
    
    //需要判断一下网址是否合法
    
    [self initWebVC];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];//加载网页
    
}

#pragma mark [接口]加载本地网页
- (void)loadLocalContent:(NSString *)content{
    
    [self initWebVC];
    [self.webView loadHTMLString:content baseURL:nil];//加载本地网页
    
}

- (void)showBackBt{
    _btnNextPage.hidden = !_webView.canGoBack;//如果有上一页才显示 按钮
}

#pragma mark - webview
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@">>> webViewDidFinishLoad");
    
    //加载标题[等页面加载完毕后 再去获取页面的标题]
    NSString *theTitle = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle) {
        self.title = theTitle;
    }
    
    [self.juHua stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@">>> didFailLoadWithError: %@", error);
    [self.juHua stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@">>> webViewDidStartLoad");
    
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
