//
//  MaoBoLiVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MaoBoLiVC.h"

@interface MaoBoLiVC ()

@property (weak, nonatomic) IBOutlet UISlider               *slider;
@property (weak, nonatomic) IBOutlet UIImageView            *imageView;
@property (nonatomic, strong) UIImage                       *img;

@end

@implementation MaoBoLiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMaoBoLiVCUI];
    
}

- (void)initMaoBoLiVCUI
{
    self.navigationItem.title = @"毛玻璃效果";
    self.view.backgroundColor = [UIColor whiteColor];
    self.slider.value = 0;
    
}

- (IBAction)slipingChangeImgeMohudu:(UISlider *)sender
{
    CGFloat value = sender.value * 100;
    self.imageView.image = [Tools setMaoBoLi:self.img andValue:value];
    
    [self toast:[NSString stringWithFormat:@"模糊度: %f", value]];
    
}

- (UIImage *)img
{
    if (_img == nil) {
        _img = [UIImage imageNamed:@"bjqs"];
    }
    return _img;
}







- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
