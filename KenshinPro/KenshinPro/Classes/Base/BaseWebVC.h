//
//  WebViewController.h
//  Sanhe
//
//  Created by kenshin on 16/11/15.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface BaseWebVC : BaseVC

@property(strong, nonatomic) NSString            *url;
@property(strong, nonatomic) NSString            *htmlString;
@property(assign, nonatomic) BOOL                hiddenLoading;
@property(assign, nonatomic) BOOL                isCache;
@property(nonatomic, retain) UIWebView           *webView;

@end
