//
//  WebViewLoadGifVC.m
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "WebViewLoadGifVC.h"


@interface WebViewLoadGifVC ()

@end

@implementation WebViewLoadGifVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"webview加载gif";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 读取gif图片数据
    NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"testXiDaBian" ofType:@"gif"]];
    UIImage *img = [UIImage imageWithData:data];
    
    CGFloat width = img.size.width;
    CGFloat height = img.size.height;
    CGFloat x = screenWidth/2.0 - width/2.0;
    CGFloat y = screenHeight/2.0 - height/2.0;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];

}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
