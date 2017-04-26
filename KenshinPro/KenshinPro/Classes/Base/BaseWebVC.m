//
//  WebViewController.m
//  Sanhe
//
//  Created by kenshin on 16/11/15.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "BaseWebVC.h"

@interface BaseWebVC () <UIWebViewDelegate>
{
    NSString *url_;
    NSString *htmlString_;
    
}
//@property(assign, nonatomic)BOOL *loadHtmlString;

@end

@implementation BaseWebVC

@synthesize url;
@synthesize htmlString;

-(void)setUrl:(NSString *)aUrl
{
    url_=aUrl;
    [self setupWebView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url_]]];
}

-(NSString *)url
{
    return url_;
}

-(void)setHtmlString:(NSString *)aHtmlString
{
    htmlString_=aHtmlString;
    [self setupWebView];
    
    [self.webView loadHTMLString:htmlString_ baseURL:nil];
}

-(NSString*)htmlString
{
    return htmlString_;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.webView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}

-(void)setupWebView
{
    if (!self.webView)
    {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
//        self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕[比例可能会缩小]
        self.webView.delegate=self;
        [self.view addSubview:self.webView];
        
    }
    
//    self.webView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}

#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self hideJuHua];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self hideJuHua];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //加载网页和本地网页都会进来
     [self showJuHua:@""];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (UIWebViewNavigationTypeFormSubmitted == navigationType) {
        return YES;
    }
    return YES;
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
