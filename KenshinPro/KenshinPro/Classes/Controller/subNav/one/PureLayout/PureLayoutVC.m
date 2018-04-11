//
//  PureLayoutVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/2/24.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "PureLayoutVC.h"
#import "PureLayout.h"

@interface PureLayoutVC ()

@end

@implementation PureLayoutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"坑爹玩意儿";
    self.view.backgroundColor = [UIColor blackColor];
    [self toast:@"请看源代码"];
    
    //这么坑爹的玩意儿 为什么还要用呢， 因为我的项目里面有这个东西。如果要优化 修改的东西是在太多了，所以 就写了这些东西
    
//   参考 https://www.jianshu.com/p/15bb1bfec5e9
//    注意:purelayout提供的方法有些是只支持iOS8及以上的，如果iOS7及以下的调用了是会奔溃
    
//    [self test_01];//边距
//    [self test_02];//大小、居中
//    [self test_03];//包含关系
//    [self test_04];//相对位置
    
    
    //https://www.jianshu.com/p/ed178ce81655 这片文章更好些
//    [self test_05];
    [self test_06];

}

//相对父视图 边距
- (void)test_01
{
    UIView *view = [UIView newAutoLayoutView];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    //1.view相对于父容器间距的位置
    [view autoPinEdgeToSuperviewEdge:ALEdgeTop    withInset:10];//相对于父容器顶部距离10
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeft   withInset:10];//相对于父容器左部距离10
    [view autoPinEdgeToSuperviewEdge:ALEdgeRight  withInset:10];//相对于父容器右部距离10
    [view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];//相对于父容器底部距离10
    
}

//大小，相对父视图 居中、 水平居中、 垂直居中
- (void)test_02
{
    UIView *view = [UIView newAutoLayoutView];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [view autoSetDimensionsToSize:CGSizeMake(300, 300)];//设置view的大小为300*300
//    [view autoSetDimension:ALDimensionHeight toSize:300];//设置view的高度为300
//    [view autoSetDimension:ALDimensionWidth toSize:300];//设置view的宽度为300
    
    [view autoCenterInSuperview];//view在父容器中心位置
//    [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];//view在父容器水平中心位置
//    [view autoAlignAxisToSuperviewAxis:ALAxisVertical];//view在父容器垂直中心位置
    
}

//包含关系
- (void)test_03
{
    UIView *fuView = [UIView newAutoLayoutView];
    UIView *ziView = [UIView newAutoLayoutView];
    fuView.backgroundColor = [UIColor redColor];
    ziView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:fuView];
    [fuView addSubview:ziView];
    
    //设置大小
    CGFloat size = 100;
    [fuView autoSetDimensionsToSize:CGSizeMake(size*3, size*3)];
    [ziView autoSetDimensionsToSize:CGSizeMake(size, size)];
    
    [fuView autoCenterInSuperview];//相对于父视图 居中
    
    [ziView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];//相对于父容器顶部距离10
    [ziView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];//相对于父容器左部距离10
//    [ziView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];//相对于父容器右部距离10
//    [ziView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];//相对于父容器底部距离10
    
}

//相对位置
- (void)test_04
{
    UIView *v1 = [UIView newAutoLayoutView];
    UIView *v2 = [UIView newAutoLayoutView];
    v1.backgroundColor = [UIColor redColor];
    v2.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:v2];
    [self.view addSubview:v1];
    
    CGFloat size = 20;
    
    //v2的大小 和 位置
    [v2 autoSetDimensionsToSize:CGSizeMake(size*3, size*3)];
    [v2 autoCenterInSuperview];//相对于父视图 居中
    
    //v1的大小 和 边距
    [v1 autoSetDimensionsToSize:CGSizeMake(size, size)];
    [v1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    
    //v1的顶部在v2的底部的20像素的位置[所以只需要确定 v2的大小位置 v1的大小和 左边距or右边距即可]
    [v1 autoPinEdge:ALEdgeTop
             toEdge:ALEdgeBottom
             ofView:v2
         withOffset:20
           relation:NSLayoutRelationEqual];
    
//    [v1 autoAlignAxis:ALAxisVertical toSameAxisOfView:v2];//v1相对于v2保持在同一个垂直中心上
//    unTest
    
}

//蓝色的view位于父view的中心，且大小是50pt
- (void)test_05
{
    UIView *blueView = [UIView newAutoLayoutView];
    [self.view addSubview:blueView];
    
    blueView.backgroundColor = [UIColor blueColor];
    [blueView autoCenterInSuperview];//位置居中「相对于父视图」
    [blueView autoSetDimensionsToSize:CGSizeMake(50.0, 50.0)];
    
}

- (void)test_06
{
    //初始化
    UIView *blueView    = [UIView newAutoLayoutView];
    UIView *redView     = [UIView newAutoLayoutView];
    UIView *yellowView  = [UIView newAutoLayoutView];
    UIView *greenView  = [UIView newAutoLayoutView];
    
    //添加视图
    [self.view addSubview:blueView];
    [self.view addSubview:redView];
    [self.view addSubview:yellowView];
    [self.view addSubview:greenView];
    
    //设置颜色
    blueView.backgroundColor    = [UIColor blueColor];
    redView.backgroundColor     = [UIColor redColor];
    yellowView.backgroundColor  = [UIColor yellowColor];
    greenView.backgroundColor   = [UIColor greenColor];
    
    //布局
//blueView位置居中「相对于父视图」size==50
    [blueView autoCenterInSuperview];
    [blueView autoSetDimensionsToSize:CGSizeMake(50.0, 50.0)];
    
//红色的View顶部与蓝色view底部位置一样，左边与蓝色的右边位置一样 宽度与蓝色的view一直，高度为40pt
    [redView autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:blueView];
    [redView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:blueView];
    [redView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:blueView];
    [redView autoSetDimension:ALDimensionHeight toSize:40.0];
    
//黄色的view的顶部与红色的view底部+10pt位置一致，高度为25pt，左右距父控件均为25pt
    [yellowView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:redView withOffset:10.0];
    [yellowView autoSetDimension:ALDimensionHeight     toSize:25.0];
    [yellowView autoPinEdgeToSuperviewEdge:ALEdgeLeft  withInset:20.0];
    [yellowView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0];
    
//绿色的view顶部与黄色view底部间距10，与父view垂直居中，高度是黄色的view的高度的两倍，宽度为150
    [greenView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:yellowView withOffset:10];
    [greenView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [greenView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:yellowView withMultiplier:2.0];//最后一个参数是倍数
    [greenView autoSetDimension:ALDimensionWidth toSize:150.0];
    
    
}

- (void)dealloc
{
    NSLog(@"tips-------->>>当前控制器:%s 已释放", object_getClassName(self));
}

@end
