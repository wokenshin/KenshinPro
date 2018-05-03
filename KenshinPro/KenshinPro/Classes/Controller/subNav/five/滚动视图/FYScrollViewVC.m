//
//  FYScrollViewVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FYScrollViewVC.h"

#import "SDCycleScrollView.h"

@interface FYScrollViewVC ()<SDCycleScrollViewDelegate>

@end

@implementation FYScrollViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self localADView];
    [self webADView];
    [self announcement];//公告
}

#pragma mark 加载本地图片
- (void)localADView
{
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            @"h7" // 本地图片请填写全名
                            ];
    
    SDCycleScrollView *adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, screenWidth, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    adView.delegate = self;
    adView.scrollDirection     = UICollectionViewScrollDirectionHorizontal;//滚动方向
    adView.autoScrollTimeInterval = 5;//自动滚动时间间隔 默认2s
    //分页栏样式
    adView.pageControlStyle    = SDCycleScrollViewPageContolStyleClassic;//水平滚动
    adView.pageDotImage        = [UIImage imageNamed:@"pageCotrol_unselected"];
    adView.currentPageDotImage = [UIImage imageNamed:@"pageCotrol_selected"];
    adView.pageControlDotSize  = CGSizeMake(10, 10);//小圆点大小
    
    [self.view addSubview:adView];
}

#pragma mark 加载网络图片 bug pageSize 设置无效 已经 issue
- (void)webADView
{
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    SDCycleScrollView *adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 254, screenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    //分页栏样式
    adView.pageControlStyle    = SDCycleScrollViewPageContolStyleClassic;//水平滚动
    adView.pageDotImage        = [UIImage imageNamed:@"pageCotrol_unselected"];
    adView.currentPageDotImage = [UIImage imageNamed:@"pageCotrol_selected"];
    adView.pageControlDotSize  = CGSizeMake(9, 9);//小圆点大小
    
    [self.view addSubview:adView];
    
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        adView.imageURLStringsGroup = imagesURLStrings;
    });
}

//公告 垂直滚动的lab
- (void)announcement
{
    //公告视图
    UIView *ggView = [[UIView alloc] init];
    ggView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ggView];
    [ggView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(454);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    //公告图标
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"platform_notice"];
    [ggView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    //小红点
    UIView *redPointView = [[UIView alloc] init];
    redPointView.backgroundColor = [UIColor redColor];
    [ggView addSubview:redPointView];
    [redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(imgV.mas_right).offset(5);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(2);
    }];
    
    //垂直滚动的lab
    NSArray *titles = @[@"kenshin11111111111111",
                        @"kenshin22222222222222",
                        @"kenshin33333333333333",
                        @"kenshin44444444444444"
                        ];

    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero
                                                                             delegate:self
                                                                     placeholderImage:nil];
    
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    cycleScrollView4.titleLabelBackgroundColor = [UIColor whiteColor];
    cycleScrollView4.titleLabelTextColor = [UIColor blackColor];
    cycleScrollView4.titlesGroup     = titles;

    [ggView addSubview:cycleScrollView4];
    [cycleScrollView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(redPointView.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}


@end
