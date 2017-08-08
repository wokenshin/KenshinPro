//
//  FXW_TextImg.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "FXW_TextImg.h"

int const fxw_Margin   = 10;

@interface FXW_TextImg()

@property (nonatomic, strong) UIImageView               *leftImgView;
@property (nonatomic, strong) UIImageView               *rightImgView;

@property (nonatomic, strong) FXW_TextImgBlock          callbackClickLeftImg;
@property (nonatomic, strong) FXW_TextImgBlock          callbackClickRightImg;

@property (nonatomic, assign) CGFloat                   fxwMargin;

@end

@implementation FXW_TextImg

#pragma mark - 左视图
- (void)fxw_setLeftImgView:(UIImageView *)leftView
{
    _leftImgView        = leftView;
    self.leftView       = _leftImgView;
    self.leftViewMode   = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(clickLeftView)];
    _leftImgView.userInteractionEnabled = YES;
    [_leftImgView addGestureRecognizer:tapGesture];
    
    
    if (_fxwMargin == fxw_Margin)//如果先设置了右视图这里就 != 10了
    {
        //设置所视图和文本框的边距
        _fxwMargin = _fxwMargin + _leftImgView.frame.size.width;
    }
    
}

- (void)clickLeftView
{
    if (_callbackClickLeftImg) {
        _callbackClickLeftImg(self);
    }
}

- (void)fxw_clickLeftImg:(FXW_TextImgBlock)resultBlock
{
    _callbackClickLeftImg = resultBlock;
}

#pragma mark - 右视图
- (void)fxw_setRightImgView:(UIImageView *)leftView
{
    _rightImgView       = leftView;
    self.rightView      = _rightImgView;
    self.rightViewMode  = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(clickRightView)];
    _rightImgView.userInteractionEnabled = YES;
    [_rightImgView addGestureRecognizer:tapGesture2];
    
    if (_fxwMargin == fxw_Margin)//如果先设置了左视图这里就 != 10了
    {
        //设置所视图和文本框的边距
        _fxwMargin = _fxwMargin + _rightImgView.frame.size.width;
    }
    
}

- (void)clickRightView
{
    if (_callbackClickRightImg) {
        _callbackClickRightImg(self);
    }
}

- (void)fxw_clickRightImg:(FXW_TextImgBlock)resultBlock
{
    _callbackClickRightImg = resultBlock;
}


#pragma mark 重写系统方法 设置文本间距
//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.fxwMargin, 0);
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.fxwMargin, 0);
}

//设置文本框margin
- (CGFloat)fxwMargin
{
    if (_fxwMargin == 0)
    {
        _fxwMargin = fxw_Margin;
    }
    return _fxwMargin;
    
}

@end
