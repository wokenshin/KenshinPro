//
//  JTiOSDevVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/19.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "JTiOSDevVC.h"
#import "XibBaseVC.h"
#import "XibTwoVC.h"
#import "OrientationsVC.h"
#import "RestructureVC.h"
#import "SwitchViewVC.h"
#import "MainTabPickerVC.h"
#import "SimpleTableVC.h"
#import "CustomTCellVC.h"
#import "CustomTCellTwoVC.h"
#import "SectionVC.h"
#import "FontsVC.h"

@interface JTiOSDevVC ()

@end

@implementation JTiOSDevVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initJTiOSDevVCUI];
}

- (void) initJTiOSDevVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"基础+封装";
    [self.view addSubview:self.tableView];
}


- (void)loadData{
    [self addDataWithTitle:@"xib基础_1" andDetail:@"2018-12-18"];
    [self addDataWithTitle:@"xib基础_2" andDetail:@"2018-12-19"];
    [self addDataWithTitle:@"旋转" andDetail:@"2018-12-21"];
    [self addDataWithTitle:@"旋转2" andDetail:@"2018-12-23"];
    [self addDataWithTitle:@"多视图" andDetail:@"2018-12-24"];
    [self addDataWithTitle:@"选取器" andDetail:@"2018-12-25"];
    [self addDataWithTitle:@"简单表" andDetail:@"2018-12-28"];
    [self addDataWithTitle:@"制定表视图单元" andDetail:@"2018-12-28"];
    [self addDataWithTitle:@"制定表视图单元2" andDetail:@"2018-12-29"];
    [self addDataWithTitle:@"分区,索引,搜索" andDetail:@"2019-1-2"];
    [self addDataWithTitle:@"导航控制器" andDetail:@"2019-1-2"];
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"导航控制器"]) {
        FontsVC *vc = [[FontsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"分区,索引,搜索"]) {
        SectionVC *vc = [[SectionVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"制定表视图单元2"]) {
        CustomTCellTwoVC *vc = [[CustomTCellTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"制定表视图单元"]) {
        CustomTCellVC *vc = [[CustomTCellVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"简单表"]) {
        SimpleTableVC *vc = [[SimpleTableVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"选取器"]) {
        MainTabPickerVC *vc = [[MainTabPickerVC alloc] init];
        
        [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            [UIView setAnimationsEnabled:oldState];
            
        } completion:^(BOOL finished) {}];
        
        return;
    }
    if ([title isEqualToString:@"多视图"]) {
        SwitchViewVC *vc = [[SwitchViewVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"旋转2"]) {
        RestructureVC *vc = [[RestructureVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"旋转"]) {
        OrientationsVC *vc = [[OrientationsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if([title isEqualToString:@"xib基础_2"]){
        XibTwoVC *vc = [[XibTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if([title isEqualToString:@"xib基础_1"]){
        XibBaseVC *vc = [[XibBaseVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}
@end
