//
//  VCN4.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCN4.h"
#import "VCN5.h"

@interface VCN4 ()

@end

@implementation VCN4

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVCN4UI];
    [self toast:@"貌似写了一些垃圾代码"];
    
}

- (void)initVCN4UI
{
    self.navigationItem.title = @"VCN4";
    
}

- (IBAction)presentANavc:(id)sender
{
    /*
     一个Navigation页面流中的某个页面Present另一个Navigation页面流
     这个过程其实就是再创建一个UINavigationController，指定它的 root vc，然后 Present 出来即可，但是注意这里Present的是这个新创建的 UINavigationController。
     */
    
    //VCN4->SubNavigationVC.VCN5 的跳转代码
    VCN5 *vc = [[VCN5 alloc] init];
    
    UINavigationController *naVC =[[UINavigationController alloc] initWithRootViewController:vc];
    
    naVC.navigationBarHidden = YES;
    [self.navigationController presentViewController:naVC animated:YES completion:nil];
    // 这里 present 的是 naVC
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
