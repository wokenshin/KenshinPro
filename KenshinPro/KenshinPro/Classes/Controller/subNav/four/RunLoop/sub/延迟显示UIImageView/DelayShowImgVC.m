//
//  DelayShowImgVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DelayShowImgVC.h"

@interface DelayShowImgVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation DelayShowImgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"延迟显示图片";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.imgView performSelector:@selector(setImage:)
                       withObject:[UIImage imageNamed:@"yingmu_guilian"]
                       afterDelay:4.0
                          inModes:@[NSDefaultRunLoopMode]];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
