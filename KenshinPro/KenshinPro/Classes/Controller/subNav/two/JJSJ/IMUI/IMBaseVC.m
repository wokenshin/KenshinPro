//
//  IMBaseVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/2/2.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "IMBaseVC.h"
#import "FXW_Define.h"
#import "IMModel.h"
#import "CellIM.h"

@interface IMBaseVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *mArrData;

@end

@implementation IMBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIMBaseVCUI];
}

- (void)initIMBaseVCUI
{
    self.navigationItem.title = @"仿微信Cell";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}



- (void)dealloc
{
    NSLog(@"tips-------->>>当前控制器:%s 已释放", object_getClassName(self));
}

@end
