//
//  OrderVC.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OrderVC2.h"

#import "RFSegmentView.h"

#import "OrderWaittingVC.h"
#import "OrderCtrlingVC.h"
#import "OrderFinishVC.h"

@interface OrderVC2 ()<RFSegmentViewDelegate>

@property (nonatomic, strong) UIScrollView    *newsScroll;

@end

@implementation OrderVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initOrderUI];
    
}

- (void)initOrderUI
{
    self.navigationItem.title = @"接单";
    [self initSegmentUI];
    [self initContentUI];
}

//分段选择
- (void)initSegmentUI
{
    RFSegmentView* segmentView = [[RFSegmentView alloc]
                                  initWithFrame:CGRectMake(0, 64, screenWidth, 60)
                                  items:@[@"待接单",@"处理中",@"已完成"]];
    segmentView.backgroundColor = [UIColor whiteColor];
    segmentView.tintColor = colorHomeBlue;
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
    //分割线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 123.5, screenWidth, 0.5)];
    lineLab.backgroundColor = colorLine;
    [self.view addSubview:lineLab];
    
}

//分段选择事件
- (void)segmentViewSelectIndex:(NSInteger)index
{
    [_newsScroll setContentOffset:CGPointMake(index * screenWidth, 0) animated:NO];//滚动到当前点击的界面

    if (index == 0)
    {
        NSLog(@"待结单");
    }
    if (index == 1)
    {
        NSLog(@"处理中");
    }
    if (index == 2)
    {
        NSLog(@"已完成");
    }
    
}

- (void)initContentUI
{
    _newsScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124 + 10, screenWidth, screenHeight)];
    _newsScroll.backgroundColor = [UIColor yellowColor];
    [_newsScroll setContentSize:CGSizeMake(screenWidth * 3, screenHeight)];//设置内容的滚动范围
    
    _newsScroll.bounces = NO;
    _newsScroll.scrollEnabled = NO;//禁止滚动
    [_newsScroll setPagingEnabled:YES];//开启滚动分页功能，如果不需要这个功能可以关闭
    [_newsScroll setShowsHorizontalScrollIndicator:NO];//隐藏滚动条
    
    for (int i = 0; i < 3; i ++)//滚动视图包含多个table
    {
        if (i == 0)//通知
        {
            OrderWaittingVC *vc = [[OrderWaittingVC alloc] init];
            vc.view.frame = CGRectMake(i * screenWidth, 0, screenWidth, screenHeight);
            [self addChildViewController:vc];
            [_newsScroll addSubview:vc.view];
            
        }
        else if (i == 1)//提问
        {
            OrderCtrlingVC *vc = [[OrderCtrlingVC alloc] init];
            vc.view.backgroundColor = [UIColor yellowColor];
            vc.view.frame = CGRectMake(i * screenWidth, 0, screenWidth, screenHeight);
            [self addChildViewController:vc];
            [_newsScroll addSubview:vc.view];
            
        }
        else if(i == 2)//系统
        {
            OrderFinishVC *vc = [[OrderFinishVC alloc] init];
            vc.view.frame = CGRectMake(i * screenWidth, 0, screenWidth, screenHeight);
            [self addChildViewController:vc];
            [_newsScroll addSubview:vc.view];
            
        }
    }
    [self.view addSubview:_newsScroll];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
