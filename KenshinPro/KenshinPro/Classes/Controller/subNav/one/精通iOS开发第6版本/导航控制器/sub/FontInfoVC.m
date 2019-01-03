//
//  FontInfoVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FontInfoVC.h"
#import "FavoritesList.h"

@interface FontInfoVC ()

@property (weak, nonatomic) IBOutlet UILabel *fontSampleLabel;//文本

@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;//滑动条

@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;//滑动条的值

@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;//收藏开关


@end

@implementation FontInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _fontSampleLabel.font = _font;
    _fontSampleLabel.text = @"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    _fontSizeSlider.value = _font.pointSize;
    _fontSizeLabel.text   = [NSString stringWithFormat:@"%.0f", _font.pointSize];
    _favoriteSwitch.on    = _isFavorites;
    
}

//滑动条 滑动事件
- (IBAction)slideFontSize:(UISlider *)slider{
    float newSize = roundf(slider.value);
    _fontSampleLabel.font = [_font fontWithSize:newSize];
    _fontSizeLabel.text = [NSString stringWithFormat:@"%0.f", newSize];
}

//是否收藏
- (IBAction)toggleFavorite:(UISwitch *)sender{
    FavoritesList *favoriteList = [FavoritesList sharedFavoritesList];
    if (sender.on) {
        [favoriteList addFavorite:self.font.fontName];
    } else {
        [favoriteList removeFavorite:self.font.fontName];
    }
}


@end
