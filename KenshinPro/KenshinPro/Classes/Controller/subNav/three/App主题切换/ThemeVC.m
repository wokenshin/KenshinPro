//
//  ThemeVC.m
//  KenshinPro
//
//  Created by kenshin on 17/5/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ThemeVC.h"
#import "FXW_Theme.h"

@interface ThemeVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgFace;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeart;
@property (weak, nonatomic) IBOutlet UIImageView *imgRect;

@property (weak, nonatomic) IBOutlet UILabel *labTest;


@end

@implementation ThemeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshUITheme];
    
}

- (IBAction)clickRedButton:(id)sender
{
    [FXW_Theme setThemeColor:@"red"];
    [self refreshUITheme];
}

- (IBAction)clickBlueButton:(id)sender
{
    [FXW_Theme setThemeColor:@"blue"];
    [self refreshUITheme];
}

- (IBAction)clickYellowButton:(id)sender
{
    [FXW_Theme setThemeColor:@"orange"];
    [self refreshUITheme];
}

- (IBAction)clickGreenButton:(id)sender
{
    [FXW_Theme setThemeColor:@"green"];
    [self refreshUITheme];
}

//刷新UI主题
- (void)refreshUITheme
{
    _imgFace.image  = [FXW_Theme imgWithName:@"face"];
    _imgHeart.image = [FXW_Theme imgWithName:@"heart"];
    _imgRect.image  = [FXW_Theme imgWithName:@"rect"];
    
    _labTest.textColor = [FXW_Theme colorLabelText];
    
}





@end
