//
//  GifContentVC.m
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "GifContentVC.h"
#import "WebViewLoadGifVC.h"
#import "SDWebImageLoadGifVC.h"

@interface GifContentVC ()

@end

@implementation GifContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self toast:@"推荐使用SDWebImage 来加载gif"];
    
}

//这种方式最Low
- (IBAction)btnWebViewLoadGif:(id)sender
{
    WebViewLoadGifVC *vc = [WebViewLoadGifVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btnSDWebImageLoadGif:(id)sender
{
    SDWebImageLoadGifVC *vc = [SDWebImageLoadGifVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
