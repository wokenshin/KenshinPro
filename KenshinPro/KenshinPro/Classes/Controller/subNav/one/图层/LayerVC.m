//
//  LayerVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/17.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "LayerVC.h"

@interface LayerVC ()

@property (weak, nonatomic) IBOutlet UITextField            *txt;
@property (weak, nonatomic) IBOutlet UIButton               *btn;


@end

@implementation LayerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"图层测试";
}

//文本最前
- (IBAction)clickBtnShowTxt:(id)sender
{
    [self.view bringSubviewToFront:_txt];
}

//按钮最前
- (IBAction)clickBtnShowBtn:(id)sender
{
    [self.view bringSubviewToFront:_btn];
}

- (IBAction)clickBtnAction:(id)sender
{
    [self toastBottom:@"点击了按钮"];
    
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
