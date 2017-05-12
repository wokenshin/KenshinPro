//
//  DDZMVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/31.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DDZMVC.h"
#import "SwitchModeVC.h"
#import "XibSelectedBtnImgVC.h"
#import "ControlMenuVC.h"
#import "BLEVC.h"
#import "FXW_BLECtrlDemoVC.h"
#import "GestureLockVC.h"

@interface DDZMVC ()

@end

@implementation DDZMVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initLockMasterAppVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"手势解锁" andDetail:@"仿支付宝的手势解锁"];
    [self addDataWithTitle:@"界面-情景模式" andDetail:@"ddzm - Masonry 布局 模态显示 "];
    [self addDataWithTitle:@"xib-按钮设置选中状态时的图片" andDetail:@"ddzm - 切换电子锁体"];
    [self addDataWithTitle:@"菜单-CollectionVew" andDetail:@"ddzm - 控制页面底部菜单"];
    [self addDataWithTitle:@"读取工程[Bundle]中的文件" andDetail:@"DFU 固件升级"];
    [self addDataWithTitle:@"蓝牙基础" andDetail:@"一些列基础功能"];
    [self addDataWithTitle:@"封装的FXW_BLECtrl演示" andDetail:@"实现对蓝牙设备的基础操作"];
    
}

- (void)initLockMasterAppVCUI
{
    self.navigationItem.title = @"ddzm";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if([title isEqualToString:@"手势解锁"])
    {
        GestureLockVC *vc = [[GestureLockVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"界面-情景模式"])
    {
        SwitchModeVC *vc = [[SwitchModeVC alloc] init];
        
        //        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        //vcm1.stringPara =@"value";// 传参
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        return;
    }
    if ([title isEqualToString:@"xib-按钮设置选中状态时的图片"])
    {
        XibSelectedBtnImgVC *vc = [[XibSelectedBtnImgVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"菜单-CollectionVew"])
    {
        ControlMenuVC *vc = [[ControlMenuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"读取工程[Bundle]中的文件"])
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.m2" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSLog(@"%@", data);
        return;
    }
    if ([title isEqualToString:@"蓝牙基础"])
    {
        BLEVC *vc = [[BLEVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"封装的FXW_BLECtrl演示"])
    {
        FXW_BLECtrlDemoVC *vc = [[FXW_BLECtrlDemoVC alloc] init];
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
