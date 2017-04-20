//
//  VCM1.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCM1.h"
#import "VCM2.h"
#import "VCN2.h"

@interface VCM1 ()

@end

@implementation VCM1

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_modalFrom)
    {
        [self toast:[NSString stringWithFormat:@"modal from %@", _modalFrom]];
    }
    
}

#pragma mark 一个Modal的页面Present另一个Modal的页面
- (IBAction)modalNextVC:(id)sender
{
    VCM2* vcm2 =[[VCM2 alloc] init];
    [vcm2 setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    vcm2.modalFrom =@"VCN1";// 传参
    [self presentViewController:vcm2 animated:YES completion:nil];
    // Present modal vc, not pop. 这里只能用 self present 。
    
}

#pragma mark Navigation页面流中的某个页面Present一个Modal的页面后Dismiss
- (IBAction)dismissCuVC:(id)sender
{
    //这里也可以dismiss的时候反向传值回去，具体内容参考博客 http://blog.csdn.net/wokenshin/article/details/50989690
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
