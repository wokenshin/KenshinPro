//
//  FXW_Theme.m
//  KenshinPro
//
//  Created by kenshin on 17/5/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_Theme.h"

@implementation FXW_Theme

static NSString *_themeColor;

+ (void)initialize
{
    _themeColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"ThemeColor"];
    if (_themeColor == nil)
    {
        _themeColor = @"blue";//默认主题？
    }
}

//设置主题
+ (void)setThemeColor:(NSString *)themeColor
{
    _themeColor = themeColor;
    
    // 保存用户选中的皮肤颜色
    [[NSUserDefaults standardUserDefaults] setObject:themeColor forKey:@"ThemeColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//获取主题下的图片
+ (UIImage *)imgWithName:(NSString *)imgName
{
    //这里的skin 是文件夹的名字
    NSString *imagePath = [NSString stringWithFormat:@"skin/%@/%@", _themeColor ,imgName];
    
    return [UIImage imageNamed:imagePath];
    
}

//从属性列表中获取背景色
+ (UIColor *)colorLabelText
{
    //这里还可以据需扩展的，比如在属性列表中再添加新的key value 就可以设置别的颜色了 如果按钮的颜色 导航栏的颜色等
    
    // 1.获取plist的路径
    NSString *plistName = [NSString stringWithFormat:@"skin/%@/Color.plist", _themeColor];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    // 2.读取颜色的点击
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3.读取对应颜色的字符串
    NSString *colorString = colorDict[@"labelBgColor"];
    
    // 4.获取颜色数组
    NSArray *colorArray = [colorString componentsSeparatedByString:@","];
    
    // 5.读取对应RGB
    NSInteger red   = [colorArray[0] integerValue];
    NSInteger green = [colorArray[1] integerValue];
    NSInteger blue  = [colorArray[2] integerValue];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
}
@end
