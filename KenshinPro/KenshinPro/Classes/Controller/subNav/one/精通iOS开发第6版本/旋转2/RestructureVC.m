//
//  RestructureVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/24.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "RestructureVC.h"

@interface RestructureVC ()


@property (weak, nonatomic) IBOutlet UIView *viewBlue;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@end

@implementation RestructureVC

static const CGFloat btnH    = 40;
static const CGFloat btnW    = 120;
static const CGFloat spacing = 20;
static const CGFloat spacingY = 20 + 64;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"108页";
    UIApplication * app = [UIApplication sharedApplication];
    UIInterfaceOrientation currentOrientation = app.statusBarOrientation;
    [self doLayoutForOrientation:currentOrientation];
}

//方法已过时
//如果要移动视图位置充分利用屏幕上的空间，需要覆盖本方法
//本方法将在旋转开始之后，最后的旋转动画发生之前被调用
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    [self doLayoutForOrientation:toInterfaceOrientation];
    
}

- (void)doLayoutForOrientation:(UIInterfaceOrientation)orientation{
    //由于项目构建在了导航控制器中 所以下面的代码和书中的代码稍有不同
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortrait];
    }
    else{
        [self layoutLandscape];
    }
}

- (void)layoutPortrait{
    
    CGRect b = self.view.bounds;
    CGFloat viewBlueSize = CGRectGetWidth(b) - (2 * spacing);
    
    _viewBlue.frame = CGRectMake(spacing, spacingY, viewBlueSize, viewBlueSize);
    
    CGFloat btnRow1y = viewBlueSize + (6 * spacing);
    CGFloat btnRow2y = btnRow1y + btnH + spacing;
    
    CGFloat btnCol1x = spacing;
    CGFloat btnCol2x = CGRectGetWidth(b) - btnW - spacing;
    
    _btn1.frame = CGRectMake(btnCol1x, btnRow1y, btnW, btnH);
    _btn2.frame = CGRectMake(btnCol2x, btnRow1y, btnW, btnH);
    _btn3.frame = CGRectMake(btnCol1x, btnRow2y, btnW, btnH);
    _btn4.frame = CGRectMake(btnCol2x, btnRow2y, btnW, btnH);
    
}

- (void)layoutLandscape{
    
    CGRect b = self.view.bounds;
    
    CGFloat viewBlueH = CGRectGetHeight(b) - (4 * spacing);
    CGFloat viewBlueW = CGRectGetWidth(b) - (2 * spacing) - btnW;
    
    _viewBlue.frame = CGRectMake(spacing, spacing + 20, viewBlueW, viewBlueH);
    
    CGFloat btnX = CGRectGetWidth(b) - btnW -spacing;
    CGFloat btnRow1y = spacing + 20 ;
    CGFloat btnRow2y = btnRow1y + btnH + spacing;
    CGFloat btnRow3y = btnRow2y + btnH + spacing;
    CGFloat btnRow4y = btnRow3y + btnH + spacing;
    
    _btn1.frame = CGRectMake(btnX, btnRow1y, btnW, btnH);
    _btn2.frame = CGRectMake(btnX, btnRow2y, btnW, btnH);
    _btn3.frame = CGRectMake(btnX, btnRow3y, btnW, btnH);
    _btn4.frame = CGRectMake(btnX, btnRow4y, btnW, btnH);
    
}

@end
