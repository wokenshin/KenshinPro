//
//  DdzmLeftMenuVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/6.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DdzmLeftMenuVC.h"
#import "LeftMenuView.h"
@interface DdzmLeftMenuVC ()<LeftMenuViewDelegate>

@property (nonatomic, strong) LeftMenuView                      *menuView;

@end

@implementation DdzmLeftMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDdzmLeftMenuVCUI];
    
}

- (void)initDdzmLeftMenuVCUI
{
    self.navigationItem.title = @"侧滑菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    WS(ws);
    [self setNavLeftBtnWithName:@"左菜单" andClickResultblock:^{
        [ws OpenLeftMenuView];
    }];
    
    //左边菜单[如果下面的代码写在其他UI前面，图层逻辑就会错误]
    self.menuView = [[LeftMenuView ShareManager] initWithContainerViewController:self];
    self.menuView.menuViewClickActionDelegate = self;
    [self.navigationController.view addSubview:self.menuView];
    
}

#pragma mark - 打开左边菜单
- (void)OpenLeftMenuView
{
    if (self.menuView.isLeftViewHidden)
    {
        [self.menuView openLeftView];
    }
    
}

#pragma mark 左边菜单关闭时候触发的代理
- (void)leftMenuOpenFinished
{
    NSLog(@"左边的菜单已完全打开");
    
}

#pragma mark 点击事件——左菜单点击代理
- (void)LeftMenuViewActionIndex:(NSString *)title
{
    
    [self toast:title];
    if ([title isEqualToString:@"退出当前账户"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.menuView closeLeftView];
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
