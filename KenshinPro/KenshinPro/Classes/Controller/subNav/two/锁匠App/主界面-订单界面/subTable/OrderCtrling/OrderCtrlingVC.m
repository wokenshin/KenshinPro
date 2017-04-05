//
//  OrderCtrlingVC.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OrderCtrlingVC.h"
#import "CellOrderCtrling.h"
#import "OrderDetailVC.h"

@interface OrderCtrlingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSMutableArray            *mDatas;
@property (nonatomic, assign) NSInteger                 pageIndex;
@property (nonatomic, strong) UIView                    *tipsNoData;//提示没有最新数据

@end

@implementation OrderCtrlingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pageIndex = 1;
    [self initTable];
    [self setupTableRefresh];//设置刷新同时加载数据
}

- (void)initTable
{
    _tipsNoData = [NoDataView tipsNoDataViewWithImgName:@"noOrder" andContent:@"暂无订单"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - Height_CellOrderCtrling)];
    _tableView.backgroundColor = colorBackground;
    
    //不显示系统的分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下面两行代码用于隐藏多余的分割线【注释掉 可看效果】
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:v];
    
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"CellOrderCtrling" bundle:nil] forCellReuseIdentifier:@"CellOrderCtrling"];
    
}

#pragma mark 设置刷新
- (void)setupTableRefresh
{
    WS(ws);
    //下拉刷新[头部刷新]【加载最新数据】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws loadLastestTableDatas];
    }];
    
    //上啦刷新[底部刷新]【加载更多数据】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws loadMoreTableDatas];
    }];
    [self.tableView.mj_footer setHidden:YES];//初始刷新的时候只显示表头的刷新ui就好了
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark 结束刷新
-(void)endRefresh
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

#pragma mark 加载最新数据
- (void)loadLastestTableDatas
{
    //先做假数据
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:@"414911762" forKey:@"orderNo"];
    [mDic setObject:@"陈先生" forKey:@"name"];
    [mDic setObject:@"煤矿村 师范大学后门" forKey:@"address"];
    [mDic setObject:@2 forKey:@"orderStatus"];
    
    ModelOrderCtrling*model = [ModelOrderCtrling mj_objectWithKeyValues:mDic];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.tableView reloadData];
    [self endRefresh];
}

#pragma mark 加载更多数据
- (void)loadMoreTableDatas
{
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mDatas count];
    
}
#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellOrderCtrling *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOrderCtrling"
                                                              forIndexPath:indexPath];
    ModelOrderCtrling *model = [_mDatas objectAtIndex:indexPath.row];
    cell.model = model;
    //抢单回调
    WS(ws);
    [cell clickOverOrderButton:^(CellOrderCtrling *cell) {
        [ws toast:@"结单啦"];
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置cell选中时 无颜色变化
    return cell;
    
}

#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height_CellOrderCtrling;
    
}

#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVC *vc = [[OrderDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray *)mDatas
{
    if (_mDatas == nil)
    {
        _mDatas = [[NSMutableArray alloc] init];
    }
    return _mDatas;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
