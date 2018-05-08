//
//  ShowDateVC.m
//  KenshinPro
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "ShowDateVC.h"
#import "NSDate+FXW.h"

@interface ShowDateVC ()

@end

@implementation ShowDateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initShowDateVCUI];
    
}

- (void)initShowDateVCUI
{
    self.title = @"显示时间";
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    long cuSystemTime  = [NSDate fxw_cuSystemTime]/1000;
    long day           = 60*60*24;
    
    //将时间戳转换成 刚刚，今天 12:30 昨天 11:30 星期几 2018.04.23
    NSString *strTime0  = [NSDate fxw_wxsjWithTimespan:cuSystemTime];
    NSString *strTime1  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - 60*10];
    NSString *strTime2  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day];
    NSString *strTime3  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*2];
    NSString *strTime4  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*3];
    NSString *strTime5  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*4];
    NSString *strTime6  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*5];
    NSString *strTime7  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*6];
    NSString *strTime8  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*7];
    NSString *strTime9  = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*8];
    NSString *strTime10 = [NSDate fxw_wxsjWithTimespan:cuSystemTime - day*9];
    
    [self addDataWithTitle:strTime0  andDetail:@""];
    [self addDataWithTitle:strTime1  andDetail:@""];
    [self addDataWithTitle:strTime2  andDetail:@""];
    [self addDataWithTitle:strTime3  andDetail:@""];
    [self addDataWithTitle:strTime4  andDetail:@""];
    [self addDataWithTitle:strTime5  andDetail:@""];
    [self addDataWithTitle:strTime6  andDetail:@""];
    [self addDataWithTitle:strTime7  andDetail:@""];
    [self addDataWithTitle:strTime8  andDetail:@""];
    [self addDataWithTitle:strTime9  andDetail:@""];
    [self addDataWithTitle:strTime10 andDetail:@""];
    
}



@end
