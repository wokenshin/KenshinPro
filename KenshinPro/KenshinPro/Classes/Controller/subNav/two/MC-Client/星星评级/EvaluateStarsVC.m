//
//  EvaluateStarsVC.m
//  GYBase
//
//  Created by kenshin on 16/6/24.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "EvaluateStarsVC.h"
#import "Tools.h"

@interface EvaluateStarsVC ()//参考 来自互联网 原理 监听滑动手势区域 从代理中处理星星的数量

@property (nonatomic, strong) UIImageView       *star_1; //67*65
@property (nonatomic, strong) UIImageView       *star_2;
@property (nonatomic, strong) UIImageView       *star_3;
@property (nonatomic, strong) UIImageView       *star_4;
@property (nonatomic, strong) UIImageView       *star_5;

@property (nonatomic, assign) BOOL              canAddStar;
@property (nonatomic, assign) NSInteger         count;

@property (nonatomic, strong) UILabel                       *labState;

@end

@implementation EvaluateStarsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initEvaluateUI];
    
}

- (void)initEvaluateUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"星级评论-支持滑动评分";
    
    CGFloat width = 67/2.0;
    CGFloat height = 65/2.0;
    CGFloat margin = 100;
    _star_1 = [[UIImageView alloc] initWithFrame:CGRectMake(margin,              100, width, height)];
    _star_2 = [[UIImageView alloc] initWithFrame:CGRectMake(margin + width   +3, 100, width, height)];
    _star_3 = [[UIImageView alloc] initWithFrame:CGRectMake(margin + width*2 +3, 100, width, height)];
    _star_4 = [[UIImageView alloc] initWithFrame:CGRectMake(margin + width*3 +3, 100, width, height)];
    _star_5 = [[UIImageView alloc] initWithFrame:CGRectMake(margin + width*4 +3, 100, width, height)];
    
    _star_1.image = [UIImage imageNamed:@"star_kong"];
    _star_2.image = [UIImage imageNamed:@"star_kong"];
    _star_3.image = [UIImage imageNamed:@"star_kong"];
    _star_4.image = [UIImage imageNamed:@"star_kong"];
    _star_5.image = [UIImage imageNamed:@"star_kong"];
    
    [self.view addSubview:_star_1];
    [self.view addSubview:_star_2];
    [self.view addSubview:_star_3];
    [self.view addSubview:_star_4];
    [self.view addSubview:_star_5];
    
    _labState = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, screenWidth - 60, 20)];
    _labState.textColor = [UIColor redColor];
    _labState.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labState];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //可以将手势范围限定在星星View的区域[但是还是有个bug 就是手如果不离开屏幕，但是移出了星星区域 还是会继续监听]
    //优化方案，就是在几个代理里面限制好手势的范围，可以搞一个View开用于控制手势的区域
    CGFloat xMin = 100;
    CGFloat xMax = CGRectGetMaxX(_star_5.frame);
    
    CGFloat yMin = 100;
    CGFloat yMax = CGRectGetMaxY(_star_5.frame);
    
    if((point.x>xMin && point.x<xMax)&&
       (point.y>yMin && point.y<yMax))
    {
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint:point];
        
    }
    else
    {
        self.canAddStar = NO;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canAddStar)
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        [self changeStarForegroundViewWithPoint:point];
        
    }
    
    return;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canAddStar)
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        [self changeStarForegroundViewWithPoint:point];
        
    }
    
    self.canAddStar = NO;
    return;
    
}

-(void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    NSInteger count = 0;
    count = count + [self changeImg:point.x image:self.star_1];
    count = count + [self changeImg:point.x image:self.star_2];
    count = count + [self changeImg:point.x image:self.star_3];
    count = count + [self changeImg:point.x image:self.star_4];
    count = count + [self changeImg:point.x image:self.star_5];

    self.count = count;
    [self checkCount:count];
    
}

-(NSInteger)changeImg:(float)x image:(UIImageView*)img
{
    if(x> img.frame.origin.x + img.frame.size.width/2)
    {
        [img setImage:[UIImage imageNamed:@"star_shi"]];
        return 2;
    }
    else if(x> img.frame.origin.x)
    {
        [img setImage:[UIImage imageNamed:@"star_kong"]];//半颗星
        return 1;
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"star_kong"]];//未选
        return 0;
    }
}

-(void)checkCount:(NSInteger)count
{
    switch (count)
    {
        case 1:
        case 2:
            NSLog(@"很差，不推荐");
            _labState.text = @"很差，不推荐";
            break;
        case 3:
        case 4:
            NSLog(@"凑合，可考虑");
            _labState.text = @"凑合，可考虑";
            break;
        case 5:
        case 6:
            NSLog(@"一般，还值得");
            _labState.text = @"一般，还值得";
            break;
        case 7:
        case 8:
            NSLog(@"不错，要推荐");
            _labState.text = @"不错，要推荐";
            break;
        case 9:
        case 10:
            NSLog(@"完美，不错过");
            _labState.text = @"完美，不错过";
            break;
        default:
            break;
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
    
}
@end
