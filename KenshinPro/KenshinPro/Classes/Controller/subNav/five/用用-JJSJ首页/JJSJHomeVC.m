//
//  JJSJHomeVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JJSJHomeVC.h"
#import "Masonry.h"

#import "SDCycleScrollView.h"
#import "FXWMenuGridView.h"
#import "FXWMenuScrollView.h"
#import "CellMyGX.h"//表cell

@interface JJSJHomeVC ()<SDCycleScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

//广告
@property (nonatomic, strong) SDCycleScrollView *adView;
@property (nonatomic, strong) NSMutableArray    *mArradViewData;

//网格
@property (nonatomic, strong) FXWMenuGridView   *gridView;
@property (nonatomic, strong) NSMutableArray    *mArrGridViewData;

//垂直滚动标签
@property (nonatomic, strong) UIView            *gongGaoView;

//应用推荐
@property (nonatomic, strong) UIView            *tjyyView;
@property (nonatomic, strong) FXWMenuScrollView *tjyyMenu;
@property (nonatomic, strong) NSMutableArray    *mArrTjyyData;

//头部视图 「包括 广告/网格/垂直滚动标签」
@property (nonatomic, strong) UIView            *headerView;

//高度
@property (nonatomic, assign) CGFloat           heightAd;
@property (nonatomic, assign) CGFloat           heightGrid;
@property (nonatomic, assign) CGFloat           heightGongGao;
@property (nonatomic, assign) CGFloat           heightYytj;
@property (nonatomic, assign) CGFloat           margin;

//table
@property (nonatomic, strong) NSMutableArray    *mArrTableData;
@property (nonatomic, strong) UITableView       *tableView;

@end

@implementation JJSJHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    //所有UI的高度
    _margin        = 10;//一共3个 最后一个用于间隔
    _heightAd      = 160;
    _heightGrid    = 160;
    _heightGongGao = 45;
    _heightYytj    = 110;
    
    CGFloat heightHeaderView = _margin*3 + _heightAd + _heightGrid + _heightGongGao + _heightYytj;
    
    //表头
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, heightHeaderView)];
    //表头内容
    [self setUpAdView];
    [self setUpGridView];
    [self setUpAnnouncement];
    [self setUpTjyy];
    
    //表
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = RGB(239, 239, 245);
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;//隐藏系统分割线
    [_tableView registerNib:[UINib nibWithNibName:@"CellMyGX" bundle:nil] forCellReuseIdentifier:@"CellMyGX"];
    _tableView.rowHeight = 160;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - 广告视图
- (void)setUpAdView
{
    _adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                 delegate:self
                                         placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    //分页栏样式
    _adView.pageControlStyle    = SDCycleScrollViewPageContolStyleClassic;//水平滚动
    _adView.pageDotImage        = [UIImage imageNamed:@"pageCotrol_unselected"];
    _adView.currentPageDotImage = [UIImage imageNamed:@"pageCotrol_selected"];
    _adView.pageControlDotSize  = CGSizeMake(9, 9);//小圆点大小
    
    [_headerView addSubview:_adView];
    
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _adView.imageURLStringsGroup = self.mArradViewData;
    });
    
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(_heightAd);
    }];
    
}

//广告数据
- (NSMutableArray *)mArradViewData
{
    if (_mArradViewData == nil) {
        _mArradViewData = [[NSMutableArray alloc] init];
        [_mArradViewData addObject:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"];
        [_mArradViewData addObject:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"];
        [_mArradViewData addObject:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    
    return _mArradViewData;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //cycleScrollView.tag 区分事件
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

#pragma mark - 网格菜单
- (void)setUpGridView
{
    //注意 这里的y=64， 因为导航栏的高度是64，如果从0开始的话 由于gridview的内容是collectionview 它会自动下移64即导航栏的高度
    //为了方便理解 可以 gridView.backgroundColor = [UIColor redColor]; 之后查看图层结构
    
    if (_gridView == nil)
    {
        _gridView = [FXWMenuGridView fxw_gridViewWithData:self.mArrGridViewData point:CGPointMake(0, 0)];
        [_headerView addSubview:_gridView];
        [_gridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_adView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(_heightGrid);
        }];
        
        
        [_gridView clickItem:^(ModelItem *model) {
            NSLog(@"click %@", model.title);
        }];
    }
    
    
}

//网格数据
- (NSMutableArray *)mArrGridViewData
{
    if (_mArrGridViewData == nil) {
        _mArrGridViewData = [[NSMutableArray alloc] init];
        ModelItem *item = [[ModelItem alloc] init];
        item.imgName = @"jjsj_1";
        item.title   = @"筑e通";
        
        ModelItem *item2 = [[ModelItem alloc] init];
        item2.imgName = @"jjsj_2";
        item2.title   = @"房产超市";
        
        ModelItem *item3 = [[ModelItem alloc] init];
        item3.imgName = @"jjsj_3";
        item3.title   = @"园林绿化";
        
        ModelItem *item4 = [[ModelItem alloc] init];
        item4.imgName = @"jjsj_4";
        item4.title   = @"供需发现";
        
        ModelItem *item5 = [[ModelItem alloc] init];
        item5.imgName = @"jjsj_5";
        item5.title   = @"办证攻略";
        
        ModelItem *item6 = [[ModelItem alloc] init];
        item6.imgName = @"jjsj_6";
        item6.title   = @"问答";
        
        ModelItem *item7 = [[ModelItem alloc] init];
        item7.imgName = @"jjsj_more";
        item7.title   = @"更多";
        
        [_mArrGridViewData addObject:item];
        [_mArrGridViewData addObject:item2];
        [_mArrGridViewData addObject:item3];
        [_mArrGridViewData addObject:item4];
        [_mArrGridViewData addObject:item5];
        [_mArrGridViewData addObject:item6];
        [_mArrGridViewData addObject:item7];
        
    }
    return _mArrGridViewData;
}

#pragma mark - 垂直lab
//公告 垂直滚动的lab
- (void)setUpAnnouncement
{
    //公告视图
    _gongGaoView = [[UIView alloc] init];
    _gongGaoView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:_gongGaoView];
    [_gongGaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_gridView.mas_bottom).offset(_margin);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(_heightGongGao);
    }];
    
    //公告图标
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"platform_notice"];
    [_gongGaoView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    //小红点
    UIView *redPointView = [[UIView alloc] init];
    redPointView.backgroundColor = [UIColor redColor];
    [Tools setCornerRadiusWithView:redPointView andAngle:2];
    [_gongGaoView addSubview:redPointView];
    [redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(imgV.mas_right).offset(5);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(4);
    }];
    
    //垂直滚动的lab
    NSArray *titles = @[@"建e通应用上线，欢迎您的使用",
                        @"办证攻略",
                        @"掌上劳务上线公告"
                        ];
    
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                                             delegate:self
                                                                     placeholderImage:nil];
    
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    cycleScrollView4.titleLabelBackgroundColor = [UIColor whiteColor];
    cycleScrollView4.titleLabelTextColor       = RGB(152, 153, 154);
    cycleScrollView4.titlesGroup               = titles;
    
    [_gongGaoView addSubview:cycleScrollView4];
    [cycleScrollView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(redPointView.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    //优化 取消说动画栋垂直lab的事件 
}

//水平滚动
- (void)setUpTjyy
{
    CGFloat hBtn = 30;
    
    _tjyyView = [[UIView alloc] init];
    _tjyyView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:_tjyyView];
    [_tjyyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_gongGaoView.mas_bottom).offset(_margin);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(_heightYytj);
    }];
    
    //应用推荐
    UIButton *btnYytj = [[UIButton alloc] init];
    [btnYytj setTitle:@"应用推荐" forState:UIControlStateNormal];
    [btnYytj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnYytj.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnYytj addTarget:self action:@selector(clickYYTJ) forControlEvents:UIControlEventTouchUpInside];
    [_tjyyView addSubview:btnYytj];
    [btnYytj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(hBtn);
    }];
    
    //显示全部
    UIButton *btnSxqb = [[UIButton alloc] init];
    [btnSxqb setTitle:@"显示全部" forState:UIControlStateNormal];
    [btnSxqb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSxqb addTarget:self action:@selector(clickXSQB) forControlEvents:UIControlEventTouchUpInside];
    btnSxqb.titleLabel.font = [UIFont systemFontOfSize:14];
    [_tjyyView addSubview:btnSxqb];
    [btnSxqb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(hBtn);
    }];
    
    
    //滚动图
    _tjyyMenu = [FXWMenuScrollView fxw_menuWithFrame:CGRectMake(10, 10, 10, 10)
                                             andData:self.mArrTjyyData];
    [_tjyyView addSubview:_tjyyMenu];
    [_tjyyMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnYytj.mas_bottom);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];

    [_tjyyMenu clickItem:^(ModelYY *model) {
        NSLog(@"click %@", model.imgUrl);
    }];
}

- (NSMutableArray *)mArrTjyyData
{
    if (_mArrTjyyData == nil) {
        _mArrTjyyData = [[NSMutableArray alloc] init];
        ModelYY *item = [[ModelYY alloc] init];
        item.imgUrl = @"h1";
        
        ModelYY *item2 = [[ModelYY alloc] init];
        item2.imgUrl = @"h2";
        
        ModelYY *item3 = [[ModelYY alloc] init];
        item3.imgUrl = @"h3";
        
        [_mArrTjyyData addObject:item];
        [_mArrTjyyData addObject:item2];
        [_mArrTjyyData addObject:item3];
    }
    return _mArrTjyyData;
}

- (void)clickYYTJ
{
    NSLog(@"clickYYTJ");
}

- (void)clickXSQB
{
    NSLog(@"clickXSQB");
}

#pragma mark - 表
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;//self.mArrTableData.count;
}

#pragma mark UITableViewDelegate
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellMyGX *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMyGX" forIndexPath:indexPath];
    cell.model = self.mArrTableData[indexPath.row];
    cell.backgroundColor = RGB(239, 239, 245);
    return cell;
}

//点击Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    IMGroup *model = [_mArrGroup objectAtIndex:indexPath.row];
//    ChatVC *vc   = [[ChatVC alloc] init];
//    vc.model       = model;
//    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}


@end
