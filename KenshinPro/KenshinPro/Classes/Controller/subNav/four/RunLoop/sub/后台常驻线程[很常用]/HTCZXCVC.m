//
//  HTCZXCVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/10/19.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "HTCZXCVC.h"

@interface HTCZXCVC ()

@property (weak, nonatomic) IBOutlet UIImageView                    *imgView;
@property (nonatomic, strong) NSThread                              *thread;

@end

@implementation HTCZXCVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"后台常驻线程";
    
}


- (IBAction)clickBtn:(id)sender
{
    
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
