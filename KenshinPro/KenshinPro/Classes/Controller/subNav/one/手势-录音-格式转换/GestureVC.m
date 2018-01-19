//
//  GestureVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/21.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GestureVC.h"
#import "RecodeVoiceVC.h"
#import "RecodePlayVC.h"

/*
 1.点按：可以设置点击次数 默认是一根手势
 2.长按：这里需要注意 长按手势会触发2次 一次是手势的开始，一次是手势的结束，需要在出发时间中进行判断
 3.轻扫：上下左右
 
 4.拖动：比较常用
 5.捏合：缩放？
 6.旋转：
 
 7.自定义手势：挠痒功能，上下扫动共3次或以上 触发
 
 */

//参考【文章一般】https://www.cnblogs.com/huangjianwu/p/4675648.html
@interface GestureVC ()

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation GestureVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"各种手势";
    
    //可以写一个分类来封装所有的手势 并返回block
    [self tapGestureWithClickTime:1];
    [self longTapGestureWithTime:0.5];
    
    //拖动和轻扫 直接设置在通一个UI上会产生冲突,只会识别拖动
    [self panGesture];
    [self swipeGesture];
    
}

#pragma mark 点按手势[可以单点 也可以多点]
- (void)tapGestureWithClickTime:(short)times
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //使用一根手指双击时，才触发点按手势识别器
    recognizer.numberOfTapsRequired    = times;//点击次数
    recognizer.numberOfTouchesRequired = 1;//手势数 ?
    [_img addGestureRecognizer:recognizer];
    _img.userInteractionEnabled = YES;
    
    
    
}

//点按事件
- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    [self tips:@"点按事件"];
}

#pragma mark 长按手势
- (void)longTapGestureWithTime:(float)time
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer.minimumPressDuration = time; //设置最小长按时间；默认为0.5秒
    [_img addGestureRecognizer:recognizer];
    _img.userInteractionEnabled = YES;
    
}

//长按事件
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)//如果这里不判断的话 事件会触发两次 一次是事件的开始，一次是事件的结束
    {
        [self tips:@"长按事件"];
    }
    
}

#pragma mark 轻扫手势 支持四个方向的轻扫，但是不同的方向要分别定义轻扫手势
- (void)swipeGesture
{
    //向右轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    
    //向左
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer2.direction = UISwipeGestureRecognizerDirectionLeft;
    
    //向上
    UISwipeGestureRecognizer *recognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer3.direction = UISwipeGestureRecognizerDirectionUp;
    
    //向下
    UISwipeGestureRecognizer *recognizer4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer4.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:recognizer];
    [self.view addGestureRecognizer:recognizer2];
    [self.view addGestureRecognizer:recognizer3];
    [self.view addGestureRecognizer:recognizer4];
    
//    [_img addGestureRecognizer:recognizer];
//    [_img addGestureRecognizer:recognizer2];
//    [_img addGestureRecognizer:recognizer3];
//    [_img addGestureRecognizer:recognizer4];
    
}

//轻扫事件
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    
    //判断方向
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            [self tips:@"轻扫 right"];
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
            [self tips:@"轻扫  left"];
        }
            break;
        case UISwipeGestureRecognizerDirectionUp:
        {
            [self tips:@"轻扫  up"];
        }
            break;
        case UISwipeGestureRecognizerDirectionDown:
        {
            [self tips:@"轻扫  down"];
        }
            break;
        default:
        {
            [self tips:@"轻扫手势 错误"];
        }
            break;
    }
}

#pragma mark 拖动手势
- (void)panGesture
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_img addGestureRecognizer:recognizer];
    _img.userInteractionEnabled = YES;
    
}

//拖动事件
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
//    CGFloat x = recognizer.view.frame.origin.x;
//    CGFloat y = recognizer.view.frame.origin.y;
//    NSLog(@"x = %f, y = %f", x, y);//当前操作view的左上角的 x,y 坐标
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint beganPoint = [recognizer translationInView:self.view];
            NSLog(@"-----Current State: Began-----");
            NSLog(@"start point (%f, %f) in View", beganPoint.x, beganPoint.y);
        }
        break;

        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"-----Current State: Changed-----");
            CGPoint currentPoint = [recognizer translationInView:self.view];
            NSLog(@"current point (%f, %f) in View", currentPoint.x, currentPoint.y);
        }
        break;
    
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"-----Current State: Ended-----");
            CGPoint endPoint = [recognizer translationInView:self.view];
            NSLog(@"end point (%f, %f) in View", endPoint.x, endPoint.y);
        }
        break;
    
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"-----Current State: Cancelled-----");
            NSLog(@"Touch was cancelled");
        }
        break;
    
        case UIGestureRecognizerStateFailed:
        {
            NSLog(@"-----Current State: Failed-----");
            NSLog(@"Failed events");
        }
        break;
            default:
            break;
    }
    
}

//吐司提示 + 日志输出
- (void)tips:(NSString *)tips
{
    if (tips != nil && ![tips isEqual:[NSNull null]] && ![tips isEqualToString:@""]){
        [self toastBottom:tips];
        NSLog(@"%@", tips);
    }
    else{
        NSLog(@"tips 提示错误 参数为空");
    }
    
}

#pragma mark 捏合


#pragma mark 旋转



#pragma mark 自定义手势
- (IBAction)clickBtnCustonGesture:(id)sender
{
    RecodeVoiceVC *vc = [[RecodeVoiceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 录音+播放
- (IBAction)clickBtnRecodeVoiceAndPlay:(id)sender
{
    RecodePlayVC *vc = [[RecodePlayVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}


@end
