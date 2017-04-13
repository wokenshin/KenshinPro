//
//  TableViewBuJuVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TableViewBuJuVC.h"
#import "VCView.h"
#import "PureTableViewVC.h"

@interface TableViewBuJuVC ()

@property (nonatomic, strong) UITableView                   *tableView;

@end

@implementation TableViewBuJuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*我有这样的想法：就是一个页面不管什么内容都可以方在一个tableView里面，这样可以兼容小屏手机
      可以用分区来区分UI的类型，也可以全部放在TableView的HeaderView中
      一下是我的测试代码，可以用纯代码布局 or xib
     */
    [self initTableViewBuJuVCUI];
    
}

- (void)initTableViewBuJuVCUI
{
    self.navigationItem.title = @"内容全在表头";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _tableView.backgroundColor = colorHomeBlue;
    
    VCView *vView = [[VCView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 1474)];//高度从xib或取的
    
    _tableView.tableHeaderView = vView;
    [self.view addSubview:_tableView];
    
    //点击一个按钮
    [vView clickButtonWithResultBlock:^(VCView *view) {
        NSLog(@"诚实的李老师");
    }];
    
    //点击黄色按钮
    WS(ws);
    [vView clickButtonNextPage:^(VCView *view) {
        PureTableViewVC *vc = [[PureTableViewVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
