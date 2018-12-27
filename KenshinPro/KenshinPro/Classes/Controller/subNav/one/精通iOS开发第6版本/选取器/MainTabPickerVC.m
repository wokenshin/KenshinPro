//
//  MainTabPickerVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "MainTabPickerVC.h"
#import "DatePickerVC.h"
#import "SingleComponentPickerVC.h"
#import "DoubleComponentPickerVC.h"
#import "DependentComponentPickerVC.h"
#import "CustomPickerVC.h"


@implementation MainTabPickerVC

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
    
    DatePickerVC                    *oneVC = [[DatePickerVC alloc] init];
    SingleComponentPickerVC    *twoVC      = [[SingleComponentPickerVC alloc] init];
    DoubleComponentPickerVC    *threeVC    = [[DoubleComponentPickerVC alloc] init];
    DependentComponentPickerVC *fourVC     = [[DependentComponentPickerVC alloc] init];
    CustomPickerVC                 *fiveVC = [[CustomPickerVC alloc] init];
    
    //返回四个导航控制器
    UINavigationController *nav1      = [self subNavOfTabBarVCWith:@"1"
                                                    viewController:oneVC
                                                         imageName:@"wb_home"
                                                 selectedImageName:@"wb_home_selected"];
    
    UINavigationController *nav2    = [self subNavOfTabBarVCWith:@"2"
                                                  viewController:twoVC
                                                       imageName:@"wb_message_center"
                                               selectedImageName:@"wb_message_center_selected"];
    
    UINavigationController *nav3 = [self subNavOfTabBarVCWith:@"3"
                                               viewController:threeVC
                                                    imageName:@"wb_discover"
                                            selectedImageName:@"wb_discover_selected"];
    
    UINavigationController *nav4      = [self subNavOfTabBarVCWith:@"4"
                                                    viewController:fourVC
                                                         imageName:@"wb_profile"
                                                 selectedImageName:@"wb_profile_selected"];
    
    UINavigationController *nav5      = [self subNavOfTabBarVCWith:@"5"
                                                    viewController:fiveVC
                                                         imageName:@"wb_profile"
                                                 selectedImageName:@"wb_profile_selected"];
    
    
    //设置TabBarVC的四个子控制器
    self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    
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



@end
