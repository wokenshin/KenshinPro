//
//  AnimationVC.m
//  GYBase
//
//  Created by doit on 16/4/29.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "AnimationVC.h"

@interface AnimationVC ()
{
    BOOL        moveFlag;//左右交替
    BOOL        changeFlag;//渐变交替
    BOOL        roundFlag;//旋转方向交替
    CGFloat     sizeHeader;
    CGFloat     angle;    //旋转角
    
    FXW_Button *wavaBtn;//波纹按钮
    //波纹动画
    UIImageView *imgV_1;
    UIImageView *imgV_2;
    UIImageView *imgV_3;
    UIImageView *imgV_4;
    UIImageView *imgV_5;

}
@end

@implementation AnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAnimationVCUI];
}

- (void)initAnimationVCUI
{
    self.view.backgroundColor = RGB2Color(41, 165, 123);
    self.navigationItem.title = @"简单动画演示";
    
    sizeHeader = 200;
    CGFloat moveRight = 40;
    
    //参照物
    self.sakuraiHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sizeHeader, sizeHeader)];
    self.sakuraiHeader.center = CGPointMake(screenWidth/2, screenHeight/2);
    self.sakuraiHeader.image = [UIImage imageNamed:@"yingmu_ok"];
    [Tools setFilletWithView:self.sakuraiHeader andAngle:sizeHeader/2];
    [self.view addSubview:self.sakuraiHeader];
    
    CGFloat margin_10 = 10;
    
    //1位移
    FXW_Button *moveLeftRight = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10, 64 + margin_10, size_normal, height_normal)];
    [moveLeftRight setTitle:@"位移" forState:UIControlStateNormal];
    moveLeftRight.backgroundColor = [UIColor blackColor];
    
    //2渐变
    FXW_Button *change = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *2 + size_normal, 64 + margin_10, size_normal, height_normal)];
    [change setTitle:@"渐变" forState:UIControlStateNormal];
    change.backgroundColor = [UIColor blackColor];
    
    //3旋转
    FXW_Button *round = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *3 + size_normal *2, 64 + margin_10, size_normal, height_normal)];
    [round setTitle:@"旋转" forState:UIControlStateNormal];
    round.backgroundColor = [UIColor blackColor];
    
    //4(位移＋渐变)
    FXW_Button *moveChange = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *4 + size_normal *3, 64 + margin_10, size_normal, height_normal)];
    [moveChange setTitle:@"位渐" forState:UIControlStateNormal];
    moveChange.backgroundColor = [UIColor blackColor];
    
    //5(位移＋旋转)
    FXW_Button *moveRound = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *5 + size_normal *4, 64 + margin_10, size_normal, height_normal)];
    [moveRound setTitle:@"位旋" forState:UIControlStateNormal];
    moveRound.backgroundColor = [UIColor blackColor];
    
    //6（渐变＋旋转）
    FXW_Button *changeRound = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *2 + size_normal, 64 + margin_10*2 + height_normal, size_normal, height_normal)];
    [changeRound setTitle:@"渐旋" forState:UIControlStateNormal];
    changeRound.backgroundColor = [UIColor blackColor];

    //7(位移＋渐变＋旋转)
    FXW_Button *moveChangeRound = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *3 + size_normal *2, 64 + margin_10*2 + height_normal, 60, height_normal)];
    [moveChangeRound setTitle:@"位渐旋" forState:UIControlStateNormal];
    moveChangeRound.backgroundColor = [UIColor blackColor];

    //8 缩放
    FXW_Button *smallBig = [[FXW_Button alloc] initWithFrame:CGRectMake(moveRight+margin_10 *6 + size_normal *3, 64 + margin_10*2 + height_normal, 60, height_normal)];
    [smallBig setTitle:@"缩放" forState:UIControlStateNormal];
    smallBig.backgroundColor = [UIColor blackColor];
    
    //波纹动画
    wavaBtn = [[FXW_Button alloc] initWithFrame:CGRectMake(0, 200, size_normal, height_normal)];
    [wavaBtn setTitle:@"波纹" forState:UIControlStateNormal];
    wavaBtn.backgroundColor = [UIColor blackColor];
    
    //事件
    WS(ws);
    //1位移
    [moveLeftRight clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws moveFunction];
    }];
    
    //2渐变
    [change clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws change];
    }];
    
    //3旋转
    [round clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws round];
    }];
    
    //4位移 渐变
    [moveChange clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws moveFunction];
        [ws change];
    }];
    
    //5位移 旋转
    [moveRound clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws moveFunction];
        [ws round];
    }];
    
    //6渐变 旋转
    [changeRound clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws change];
        [ws round];
    }];
    
    //7位移 渐变 旋转
    [moveChangeRound clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws moveFunction];
        [ws change];
        [ws round];
    }];
    
    //缩放
    [smallBig clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws smallBig:ws.sakuraiHeader];
    }];
    
    [wavaBtn clickButtonWithResultBlock:^(FXW_Button *button) {
        [ws startAnimationOfWave];
    }];
    
    //声波UI
    CGFloat sizeWave = sizeHeader + 30;
    imgV_1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sizeWave, sizeWave)];
    imgV_2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sizeWave, sizeWave)];
    imgV_3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sizeWave, sizeWave)];
    imgV_4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sizeWave, sizeWave)];
    imgV_5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, sizeWave, sizeWave)];
    
    UIImage *img = [UIImage imageNamed:@"wave"];
    imgV_1.image = img;
    imgV_2.image = img;
    imgV_3.image = img;
    imgV_4.image = img;
    imgV_5.image = img;
    
    imgV_1.hidden = YES;
    imgV_2.hidden = YES;
    imgV_3.hidden = YES;
    imgV_4.hidden = YES;
    imgV_5.hidden = YES;
    
    imgV_1.center = CGPointMake(screenWidth/2, screenHeight/2);
    imgV_2.center = CGPointMake(screenWidth/2, screenHeight/2);
    imgV_3.center = CGPointMake(screenWidth/2, screenHeight/2);
    imgV_4.center = CGPointMake(screenWidth/2, screenHeight/2);
    imgV_5.center = CGPointMake(screenWidth/2, screenHeight/2);

    
    //添加视图
    [self.view addSubview:moveLeftRight];
    [self.view addSubview:change];
    [self.view addSubview:round];
    [self.view addSubview:moveChange];
    [self.view addSubview:moveRound];
    [self.view addSubview:changeRound];
    [self.view addSubview:moveChangeRound];
    [self.view addSubview:smallBig];
    [self.view addSubview:wavaBtn];
    
    //波纹
    [self.view addSubview:imgV_1];
    [self.view addSubview:imgV_2];
    [self.view addSubview:imgV_3];
    [self.view addSubview:imgV_4];
    [self.view addSubview:imgV_5];
}

#pragma mark 位移
- (void)moveFunction
{
    CGFloat margin_10 = 10;
    
    [UIView beginAnimations:@"PositionAnition" context:NULL];
    [UIView setAnimationDuration:1];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    CGFloat X = 0;
    if (moveFlag)
    {
        moveFlag = NO;
        X = screenWidth - sizeHeader/2 - margin_10;
    }
    else
    {
        moveFlag = YES;
        X = margin_10 + sizeHeader/2;
    }
    self.sakuraiHeader.center = CGPointMake(X, screenHeight/2);
//    [UIView setAnimationDidStopSelector:@selector(scareAnimation)];
    [UIView commitAnimations];
}

#pragma mark 渐变
- (void)change
{
    //动画
    [UIView animateWithDuration:3.0 animations:^{
        if (changeFlag) {
            changeFlag = NO;
            self.sakuraiHeader.alpha = 1.0;
        }
        else{
            changeFlag = YES;
            self.sakuraiHeader.alpha = 0.0;
        }
        
    } completion:^(BOOL finished)
     {
//         self.sakuraiHeader.alpha = 0.0;
     }];

}

//旋转
- (void)round
{
    angle += 180;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationDelegate:self];
    self.sakuraiHeader.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

//缩放
- (void)smallBig:(UIView *)view
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
    
}

#pragma mark 声纹码动画
- (void)startAnimationOfWave
{
    imgV_1.hidden = NO;
    imgV_2.hidden = NO;
    imgV_3.hidden = NO;
    imgV_4.hidden = NO;
    imgV_5.hidden = NO;
    
    [self donghuaWithImgView:imgV_1 andDelay:0.0];
    [self donghuaWithImgView:imgV_2 andDelay:0.7];
    [self donghuaWithImgView:imgV_3 andDelay:1.4];
    [self donghuaWithImgView:imgV_4 andDelay:2.1];
    [self donghuaWithImgView:imgV_5 andDelay:2.8];
    
    wavaBtn.enabled = NO;
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:4.0f];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.sakuraiHeader.image = [UIImage imageNamed:@"yingmu_guilian"];

}

- (void)delayMethod
{
    wavaBtn.enabled = YES;
    self.sakuraiHeader.image = [UIImage imageNamed:@"yingmu_ok"];
    self.view.backgroundColor = RGB2Color(41, 165, 123);
}

- (void)donghuaWithImgView:(UIImageView *)imgV andDelay:(CGFloat )delay
{
    [UIView animateWithDuration:2.0 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        
        imgV.transform = CGAffineTransformScale([self transformForOrientation], 3, 3);
        imgV.alpha = 0;
        
    } completion:^(BOOL finished)
     {
         imgV.transform = CGAffineTransformScale([self transformForOrientation], 1, 1);
         imgV.alpha = 1;
         imgV.hidden = YES;
     }];
}

- (CGAffineTransform)transformForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationLandscapeLeft == orientation)
    {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    }
    else if (UIInterfaceOrientationLandscapeRight == orientation)
    {
        return CGAffineTransformMakeRotation(M_PI/2);
    }
    else if (UIInterfaceOrientationPortraitUpsideDown == orientation)
    {
        return CGAffineTransformMakeRotation(-M_PI);
    }
    else
    {
        return CGAffineTransformIdentity;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    wavaBtn = nil;//波纹按钮
    
    //波纹动画
    imgV_1 = nil;
    imgV_2 = nil;
    imgV_3 = nil;
    imgV_4 = nil;
    imgV_5 = nil;
}

@end
