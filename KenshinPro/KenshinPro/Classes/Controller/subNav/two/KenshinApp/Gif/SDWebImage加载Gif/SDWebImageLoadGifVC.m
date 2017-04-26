//
//  SDWebImageLoadGifVC.m
//  GYBase
//
//  Created by kenshin on 16/8/26.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SDWebImageLoadGifVC.h"
#import "UIImage+GIF.h"

@interface SDWebImageLoadGifVC ()

@end

@implementation SDWebImageLoadGifVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"testXiDaBian" ofType:@"gif"];
    NSData   *data  = [NSData dataWithContentsOfFile:path];
    UIImage  *image = [UIImage sd_animatedGIFWithData:data];//SDWebImage 获取gif
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, image.size.width, image.size.height)];
    imgv.image = image;
    [self.view addSubview:imgv];
    
    UITapGestureRecognizer *tapOpenLock = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOpenLock)];
    imgv.userInteractionEnabled = YES;
    [imgv addGestureRecognizer:tapOpenLock];
    
}

- (void)clickOpenLock
{
    NSLog(@"测试一下手势");
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
