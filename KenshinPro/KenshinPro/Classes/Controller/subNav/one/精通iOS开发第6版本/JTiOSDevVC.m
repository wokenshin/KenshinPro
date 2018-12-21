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
}

- (void)clickCellWithTitle:(NSString *)title{
    
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
