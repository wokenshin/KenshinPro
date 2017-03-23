//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "FXW_TextView.h"

@interface FXW_TextView()<UITextViewDelegate>

@property (nonatomic, strong) UILabel                           *placeholderLabel;

/**
 设置该属相 可以限制文本框输入内容的长度
 */
@property (nonatomic, assign) NSInteger                         limitLen;

@property (nonatomic, copy)   FXW_TextViewBlock                 limitCallback;
@property (nonatomic, copy)   FXW_TextViewBlock                 editingCallback;

@end
@implementation FXW_TextView

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self awakeFromNib];
    }
    return self;
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    float left=5,top=2,hegiht=30;
    
    self.font = [UIFont systemFontOfSize:14.0];
    
    self.placeholderColor = [UIColor lightGrayColor];
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                                  , CGRectGetWidth(self.frame)-2*left, hegiht)];
    _placeholderLabel.font = self.placeholderFont?self.placeholderFont:self.font;
    _placeholderLabel.textColor = self.placeholderColor;
    _placeholderLabel.text = self.placeholder;
    
    [self addSubview:_placeholderLabel];
    
    
    self.delegate = self;
    
}

//设置占位提示
-(void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""])
    {
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.text = placeholder;
        _placeholder = placeholder;
    }
    
}

//设置占位文本字体大小
-(void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderLabel.font = self.placeholderFont ? self.placeholderFont:self.font;
    
}

#pragma mark 代理
-(void)textViewDidChange:(UITextView *)textView
{
    //当输入内容时 隐藏提示文本
    if (self.text.length > 0)
    {
        _placeholderLabel.hidden = YES;
    }
    else
    {
        _placeholderLabel.hidden = NO;
    }
    
    //如果有设置文本的长度以下方法会对编辑文本进行裁剪，只保留设置长度的字符串
    if (_limitLen > 0)
    {
        NSUInteger len = textView.text.length;
        if (len > _limitLen)
        {
            self.text = [textView.text substringToIndex:_limitLen-1];//从0开始取
            if (_limitCallback)
            {
                _limitCallback(self);
            }
        }
    }
    
    if (_editingCallback)
    {
        _editingCallback(self);
    }
    
}

- (void)setLimitLen:(NSInteger)len andWithResultBlock:(FXW_TextViewBlock)block
{
    _limitLen = len;
    _limitCallback = block;
    
}

- (void)textEditingWithResultBlock:(FXW_TextViewBlock)block
{
    _editingCallback = block;
    
}

-(void)dealloc
{
    [_placeholderLabel removeFromSuperview];
    
}

@end

