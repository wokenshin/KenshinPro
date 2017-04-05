//
//  OrderVC.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OrderVC.h"

#import "YQYPiecewiseView.h"

#import "OrderWaittingVC.h"
#import "OrderCtrlingVC.h"
#import "OrderFinishVC.h"

@interface OrderVC ()

@property (nonatomic, strong) UIScrollView              *newsScroll;

@end

@implementation OrderVC

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
    NSArray *arrar = [NSArray arrayWithObjects:@"待接单",@"处理中",@"已完成", nil];
    
    YQYPiecewiseView *piecew = [[YQYPiecewiseView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, 60)];
    piecew.backgroundColor = [UIColor whiteColor];
    piecew.type = PiecewiseInterfaceTypeMobileLin;
    piecew.textFont = [UIFont systemFontOfSize:18];
    piecew.textNormalColor = colorTextGray;
    piecew.textSeletedColor = colorHomeBlue;
    piecew.linColor = colorHomeBlue;
    [piecew loadTitleArray:arrar];
    [self.view addSubview:piecew];
    
    WS(ws);
    //分段选择事件
    [piecew selectedItemWithResultBlock:^(YQYPiecewiseView *view, NSInteger index) {
        switch (index)
        {
            case 0:
            {
                [ws.newsScroll setContentOffset:CGPointMake(0, 0) animated:YES];
            }
                break;
            case 1:
            {
                [ws.newsScroll setContentOffset:CGPointMake(screenWidth, 0) animated:YES];
            }
                break;
            case 2:
            {
                [ws.newsScroll setContentOffset:CGPointMake(screenWidth*2, 0) animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }];
    
}

- (void)initContentUI
{
    self.view.backgroundColor = [UIColor whiteColor];//背景
    _newsScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 124+10, screenWidth, screenHeight)];
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
