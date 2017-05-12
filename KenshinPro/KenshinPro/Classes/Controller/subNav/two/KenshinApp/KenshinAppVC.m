//
//  KenshinAppVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/10.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "KenshinAppVC.h"
#import "AnimationVC.h"
#import "ClearCachesVC.h"
#import "MaoBoLiVC.h"
#import "GifContentVC.h"
#import "NavBarCustomVC.h"
#import "ScanVC.h"

@interface KenshinAppVC ()

@end

@implementation KenshinAppVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initKenshinAppVCUI];
    [self loadData];
    
}

- (void)initKenshinAppVCUI
{
    self.navigationItem.title = @"KenshinApp";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"基础动画" andDetail:@"一些基础动画，bwzk中的开锁动画"];
    [self addDataWithTitle:@"清除缓存" andDetail:@"kenshinApp mc时期"];
    [self addDataWithTitle:@"毛玻璃效果" andDetail:@"kenshinApp mc时期"];
    [self addDataWithTitle:@"Gif" andDetail:@"显示gif图片 两种方式 SD or webview"];
    [self addDataWithTitle:@"自定义导航栏" andDetail:@"推荐修改self.nav.titleView来实现自定义"];
    [self addDataWithTitle:@"扫描二维码" andDetail:@"MC时期做"];
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"基础动画"])
    {
        AnimationVC *vc = [[AnimationVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"清除缓存"])
    {
        ClearCachesVC *vc = [[ClearCachesVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"毛玻璃效果"])
    {
        MaoBoLiVC *vc = [[MaoBoLiVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"Gif"])
    {
        GifContentVC *vc = [[GifContentVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"自定义导航栏"])
    {
        NavBarCustomVC *vc = [[NavBarCustomVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"扫描二维码"])
    {
        ScanVC *vc = [[ScanVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
