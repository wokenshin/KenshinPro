//
//  VCM2.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCM2.h"
#import "VCM1.h"

@interface VCM2 ()

@end

@implementation VCM2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_modalFrom)
    {
        [self toast:[NSString stringWithFormat:@"modal from %@", _modalFrom]];
    }
    
}

#pragma mark 一个Modal的页面Present另一个Modal的页面后Dismiss
- (IBAction)dismiss2:(id)sender
{
    //dismiss 传值
    if([self.presentingViewController isKindOfClass:[VCM1 class]])
    {
        if ([self.presentingViewController isKindOfClass:[VCM1 class]])
        {
            VCM1* vcm1 =(VCM1*)self.presentingViewController;
            vcm1.modalFrom =@"value";// 传参
        }
        
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
