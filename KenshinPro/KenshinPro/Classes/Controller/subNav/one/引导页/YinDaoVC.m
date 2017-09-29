//
//  YinDaoVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/9/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//


//参考[其实就是抄] http://www.jb51.net/article/104133.htm
#import "YinDaoVC.h"

@interface YinDaoVC ()<UIScrollViewDelegate>

//分页点
@property (nonatomic, strong)UIPageControl                          *pageControl;


@end

@implementation YinDaoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (BOOL)initGuidePageWithImgNames:(NSArray *)imgNames
           pageControlColorNormal:(UIColor *)colorNormal
         pageControlColorSelected:(UIColor *)colorSelected
                   finishBtnTitle:(NSString *)finishBtnTitle
{
    //检验参数是否合法
    if ([imgNames isEqual:[NSNull null]] || imgNames == nil || [imgNames count] == 0) {
        NSLog(@"设置引导页失败 引导页图片为空");
        return NO;
    }
    //如果没有设置引导页分页UI颜色 设置默认色
    if (colorNormal == nil) {
        colorNormal = [UIColor whiteColor];
    }
    if (colorSelected == nil) {
        colorSelected = [UIColor redColor];
    }
    if ([finishBtnTitle isEqual:[NSNull null]] || finishBtnTitle == nil || [finishBtnTitle isEqualToString:@""]) {
        finishBtnTitle = @"完成";
    }
    
    
    //创建ScrollView
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.frame = self.view.bounds;
    //设置边缘不弹跳
    sv.bounces = NO;
    //整页滚动
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    
    NSUInteger counterImg = [imgNames count];
    for(NSInteger i=0; i< counterImg; i++)
    {
        NSString *imgName = imgNames[i];
        UIImage *image = [UIImage imageNamed:imgName];
        if(image == nil)
        {
            NSLog(@"设置引导页失败 未找到引导页图片:%@", imgName);
            return NO;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        CGRect frame = CGRectZero;
        frame.origin.x = i * sv.frame.size.width;
        frame.size = sv.frame.size;
        imageView.frame = frame;
        [sv addSubview:imageView];
        
        if(i+1 == counterImg)
        {
            //开启图片的用户点击功能
            imageView.userInteractionEnabled = YES;
            //加个按钮
            UIButton *button = [[UIButton alloc]init];
            
            button.frame = CGRectMake((imageView.frame.size.width-150)/2, imageView.frame.size.height*0.8, 150, 40);
            button.backgroundColor = [UIColor orangeColor];
            [button setTitle:finishBtnTitle forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [imageView addSubview:button];
            [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    sv.contentSize = CGSizeMake(counterImg * sv.frame.size.width, sv.frame.size.height);
    
    [self.view addSubview:sv];
    
    //加入页面指示控件PageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl  = pageControl;
    //设置frame
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 20);
    //分页面的数量
    pageControl.numberOfPages = counterImg;
    //设置小圆点渲染颜色
    pageControl.pageIndicatorTintColor = colorNormal;
    //设置当前选中小圆点的渲染颜色
    pageControl.currentPageIndicatorTintColor = colorSelected;
    //关闭用户点击交互
    pageControl.userInteractionEnabled = NO;
    
    [self.view addSubview:pageControl];
    
    sv.delegate = self;
    
    return YES;
    
}

#pragma mark 滚动视图代理 控制分页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if(offset.x<=0)
    {
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    NSUInteger index = round(offset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = index;
    
}

#pragma mark 切换到根视图
- (void)enter
{
    //切换根控制器 有一个渐变的效果
    // options是动画选项
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];//可以在这里切换控制器
        [UIView setAnimationsEnabled:oldState];
        
    } completion:^(BOOL finished) {}];
    
}

//获取当前栈顶控制器
- (UIViewController *)getCurrentShowVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
