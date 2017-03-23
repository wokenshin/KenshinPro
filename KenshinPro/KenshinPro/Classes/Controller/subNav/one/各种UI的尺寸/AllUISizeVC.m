//
//  AllUISizeVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/23.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AllUISizeVC.h"

@interface AllUISizeVC ()

@end

@implementation AllUISizeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAllUISizeVCUI];
    
}

- (void)initAllUISizeVCUI
{
    self.navigationItem.title = @"各种UI的size";
    //如果用table来显示 就更换父类vc[推荐]
    //如果用滚动视图来显示 就用Masonry
    
    
    /*
     现在网上搜一遍，然后添加到本vc中
     
     AppIcon
     手机屏幕
     启动页[sb 添加一张全屏6plus分辨率的即可，貌似在4s上显示会有问题 待测试下]， 或者使用imageSources这个需要很多张图片
          [用vc来实现的启动页：这样做的有点是只需要两张图片，也可以随便搞动画， 缺点是没有sb的launch快(慢了一丢丢)]
     状态栏
     导航条
     tabBar
     
     屏幕快照[主要是方便审核，推荐用最大分辨率的 只需要一套即可]
     
     推荐按钮的高度、推荐文本框的高度、推荐广告[滚动视图]的高度 等等
     
     
     */
}


@end
