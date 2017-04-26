//
//  ScanVC.m
//  GYBase
//
//  Created by kenshin on 16/8/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "ScanVC.h"
#import "ScanErWeiMaOneVC.h"
#import "VScanErWeiMaTwoVC.h"

@interface ScanVC ()

@end

@implementation ScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//扫描二维码：样式一
- (IBAction)btnScanStyleOne:(id)sender
{
    ScanErWeiMaOneVC *vc = [ScanErWeiMaOneVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//扫描二维码：样式二
- (IBAction)btnScanStyleTwo:(id)sender
{
    VScanErWeiMaTwoVC *vc = [VScanErWeiMaTwoVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
