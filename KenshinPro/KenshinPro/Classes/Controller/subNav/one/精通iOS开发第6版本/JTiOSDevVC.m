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
#import "DialogViewerVC.h"
#import "PersistenceVC.h"
#import "SQLitePersistence.h"
#import "CoreDataPersistenceVC.h"
#import "SlowWorkerVC.h"
#import "AppStateVC.h"
#import "QuartzFunVC.h"
#import "TouchExplorerVC.h"
#import "SwipesVC.h"
#import "SwipesTwoVC.h"
#import "TapTapsVC.h"
#import "PinchMeVC.h"
#import "CheckPleaseVC.h"
#import "WhereAmIVC.h"
#import "MotionMonitorVC.h"
#import "MMVC.h"
#import "ShakeAndBreakVC.h"
#import "BallVC.h"


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
    self.navigationItem.title = @"精通iOS开发第6版本";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
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
    [self addDataWithTitle:@"集合视图" andDetail:@"2019-1-3"];
    [self addDataWithTitle:@"plist 和 归档" andDetail:@"2019-1-7"];
    [self addDataWithTitle:@"SQLite" andDetail:@"2019-1-9"];
    [self addDataWithTitle:@"CoreData" andDetail:@"2019-1-9"];
    [self addDataWithTitle:@"iCloud 之旅[必须用真机]" andDetail:@"2019-1-16"];
    [self addDataWithTitle:@"SlowWorker" andDetail:@"GCD章节"];
    [self addDataWithTitle:@"App状态" andDetail:@"AppDelegate 前台 后台 等等"];
    [self addDataWithTitle:@"CoreGraphics绘图" andDetail:@"QuartzFun"];
    [self addDataWithTitle:@"游戏 Sprite Kit" andDetail:@"第六版内容过于陈旧 在此省略"];
    [self addDataWithTitle:@"手势" andDetail:@"2019-1-23"];
    [self addDataWithTitle:@"轻扫 代理实现" andDetail:@"2019-1-24"];
    [self addDataWithTitle:@"轻扫 手势" andDetail:@"2019-1-24"];
    [self addDataWithTitle:@"Tap Taps" andDetail:@"避免手势冲突"];
    [self addDataWithTitle:@"缩放+旋转" andDetail:@"2019-1-28"];
    [self addDataWithTitle:@"自定义手势" andDetail:@"感觉书中代码辣鸡，手势并不标准"];
    [self addDataWithTitle:@"定位+地图" andDetail:@"2019-1-29"];
    [self addDataWithTitle:@"陀螺仪和加速计" andDetail:@"2019-1-30 被动获取"];
    [self addDataWithTitle:@"陀螺仪和加速计2" andDetail:@"2019-1-31 主动获取"];
    [self addDataWithTitle:@"死劲儿摇晃手机" andDetail:@"2019-1-31"];
    [self addDataWithTitle:@"滚弹珠程序" andDetail:@"2019-1-31"];
    
    
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"滚弹珠程序"]) {
        BallVC *vc = [[BallVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"死劲儿摇晃手机"]) {
        ShakeAndBreakVC *vc = [[ShakeAndBreakVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"陀螺仪和加速计2"]) {
        MMVC *vc = [[MMVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"陀螺仪和加速计"]) {
        MotionMonitorVC *vc = [[MotionMonitorVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"定位+地图"]) {
        WhereAmIVC *vc = [[WhereAmIVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"自定义手势"]) {
        CheckPleaseVC *vc = [[CheckPleaseVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"缩放+旋转"]) {
        PinchMeVC *vc = [[PinchMeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"Tap Taps"]) {
        TapTapsVC *vc = [[TapTapsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"轻扫 手势"]) {
        SwipesTwoVC *vc = [[SwipesTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"轻扫 代理实现"]) {
        SwipesVC *vc = [[SwipesVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"手势"]) {
        TouchExplorerVC *vc = [[TouchExplorerVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"CoreGraphics绘图"]) {
        QuartzFunVC *vc = [[QuartzFunVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"App状态"]) {
        AppStateVC *vc = [[AppStateVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"SlowWorker"]) {
        SlowWorkerVC *vc = [[SlowWorkerVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"iCloud 之旅[必须用真机]"]) {
        [self alertSystemTitle:@"代码忽略" message:@"" OK:^{}];
        return;
    }
    if ([title isEqualToString:@"CoreData"]) {
        CoreDataPersistenceVC *vc = [[CoreDataPersistenceVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"SQLite"]) {
        SQLitePersistence *vc = [[SQLitePersistence alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"plist 和 归档"]) {
        PersistenceVC *vc = [[PersistenceVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
//        NSArray *arrPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *pathDoc = arrPath[0];
//        NSLog(@"App应用程序的 doc路径：%@", pathDoc);
//
//        NSString *pathTmp = NSTemporaryDirectory();
//        NSLog(@"App应用程序的 tmp路径：%@", pathTmp);
    }
    if ([title isEqualToString:@"集合视图"]) {
        DialogViewerVC *vc = [[DialogViewerVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
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
