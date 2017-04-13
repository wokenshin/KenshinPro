//
//  SLock3SwitchLockTyepVC.m
//  Sanhe
//
//  Created by kenshin on 17/3/20.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import "XibSelectedBtnImgVC.h"

@interface XibSelectedBtnImgVC ()

@property (weak, nonatomic) IBOutlet UIButton *btnElec;

@property (weak, nonatomic) IBOutlet UIButton *btnMechine;

@property (weak, nonatomic) IBOutlet UIButton *btnApplication;

@end

@implementation XibSelectedBtnImgVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置锁体";
    [Tools setFilletWithView:_btnApplication andAngle:4];
    _btnMechine.selected = YES;
    
}

//注意：点击按钮的时候需要设置 按钮的 selected， 否者 xib中设置的选中时候的图片将无法显示
- (IBAction)btnElect:(UIButton *)btn
{
    _btnElec.selected    = YES;
    _btnMechine.selected = NO;
    
}

- (IBAction)btnMechine:(UIButton *)btn
{
    _btnElec.selected    = NO;
    _btnMechine.selected = YES;
    
}

- (IBAction)btnApplication:(UIButton *)sender
{
    if (_btnElec.selected)
    {
        [self toastBottom:@"电子锁体"];
    }
    if (_btnMechine.selected)
    {
        [self toastBottom:@"机械锁体"];
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
