//
//  SDWebImgVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/14.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "SDWebImgVC.h"
#import "UIImageView+WebCache.h"

#define USERAGENT @"Mozilla/5.0 (iPhone; CPU iPhone OS 5_1_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B206 Safari/7534.48.3"

@interface SDWebImgVC ()

@end

@implementation SDWebImgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"设置代理";
    
    [[SDWebImageDownloader sharedDownloader] setValue:USERAGENT forHTTPHeaderField:@"User-Agent"];
    
    UIImageView *imgTest = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    NSString *url = @"http://img4.imgtn.bdimg.com/it/u=4219989109,2977561849&fm=27&gp=0.jpg";
    [imgTest sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"yingmu_guilian"]];
    [self.view addSubview:imgTest];
    
}



@end
