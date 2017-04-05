//
//  OrderWaittingVC.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OrderWaittingVC.h"
#import "CellOrderWaitting.h"

@interface OrderWaittingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, strong) NSMutableArray            *mDatas;
@property (nonatomic, assign) NSInteger                 pageIndex;
@property (nonatomic, strong) UIView                    *tipsNoData;//提示没有最新数据

@end

@implementation OrderWaittingVC

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - Height_CellOrderWaitting)];
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
    [_tableView registerNib:[UINib nibWithNibName:@"CellOrderWaitting" bundle:nil]
     forCellReuseIdentifier:@"CellOrderWaitting"];
    
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
    [mDic setObject:@"2017-03-28 12:12" forKey:@"date"];
    [mDic setObject:@"范先生" forKey:@"name"];
    [mDic setObject:@"高新区管委 科技大厦12楼" forKey:@"address"];
    [mDic setObject:@"锁把手损坏了，没有办法开门" forKey:@"fixContent"];

    ModelOrderWaitting *model = [ModelOrderWaitting mj_objectWithKeyValues:mDic];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.mDatas addObject:model];
    [self.tableView reloadData];
    
//    if ([self.mDatas count] == 0)
//    {
//        _tableView.tableHeaderView = _tipsNoData;
//    }
//    else
//    {
//        _tableView.tableHeaderView = nil;
//    }
    [self endRefresh];
    
}

#pragma mark 加载更多数据
- (void)loadMoreTableDatas
{
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mDatas count];
    
}
#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellOrderWaitting *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOrderWaitting"
                                                              forIndexPath:indexPath];
    ModelOrderWaitting *model = [self.mDatas objectAtIndex:indexPath.row];
    cell.model = model;
    //抢单回调
    WS(ws);
    [cell clickAcceptOrderButton:^(CellOrderWaitting *cell) {
        [ws toast:@"您接了 范先生的订单"];
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置cell选中时 无颜色变化
    return cell;
    
}

#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height_CellOrderWaitting;
    
}

#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
