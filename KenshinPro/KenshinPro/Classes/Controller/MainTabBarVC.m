//
//  MainTabBarVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "MainTabBarVC.h"

#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"
#import "FourVC.h"

@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMainUI];
    
}

#pragma mark initMainUI
- (void)initMainUI
{
    //必须的两个属性设置[如果没有 nav就没有返回 和 title了]
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = NO;
    
    OneVC       *oneVC      = [[OneVC alloc] init];
    TwoVC       *twoVC      = [[TwoVC alloc] init];
    ThreeVC     *threeVC    = [[ThreeVC alloc] init];
    FourVC      *fourVC     = [[FourVC alloc] init];
    
    //返回四个导航控制器
    UINavigationController *navHome      = [self subNavOfTabBarVCWith:@"基础"
                                                       viewController:oneVC
                                                            imageName:@"tabbar_home_normal"
                                                    selectedImageName:@"tabbar_home_selected"];
    
    UINavigationController *navExpert    = [self subNavOfTabBarVCWith:@"APP"
                                                       viewController:twoVC
                                                            imageName:@"tabbar_expert_normal"
                                                    selectedImageName:@"tabbar_expert_selected"];
    
    UINavigationController *navQuestions = [self subNavOfTabBarVCWith:@"进阶"
                                                       viewController:threeVC
                                                            imageName:@"tabbar_qusetion_normal"
                                                    selectedImageName:@"tabbar_question_selected"];
    
    UINavigationController *navMine      = [self subNavOfTabBarVCWith:@"待定"
                                                       viewController:fourVC
                                                            imageName:@"tabbar_mine_normal"
                                                    selectedImageName:@"tabbar_mine_selected"];
    
    
    //设置TabBarVC的四个子控制器
    self.viewControllers = [NSArray arrayWithObjects:navHome, navExpert, navQuestions, navMine, nil];
    
}

#pragma mark 创建TabBarVC 的子控制器 并设置为Nav
-(UINavigationController *)subNavOfTabBarVCWith:(NSString *)title
                                 viewController:(UIViewController *)viewController
                                      imageName:(NSString *)imageName
                              selectedImageName:(NSString *)selectedImageName
{
    
    //IOS 7以上要设置图片渲染模式
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//禁止渲染
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//禁止渲染
    
    viewController.hidesBottomBarWhenPushed = NO;//当进入到viewController时 是否要隐藏底部的 bar
    
    UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    
    //设置Tab选中时文本文字颜色
    
    [navViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB2Color(255,70,70)}
                                                forState:UIControlStateSelected];
    
    //设置Tab未选中时颜色
    
    [navViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB2Color(179, 179, 179)}
                                                forState:UIControlStateNormal];
    
    if(image == nil || viewController == nil)
    {
        navViewController.tabBarItem.enabled = NO;
    }
    return navViewController;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
