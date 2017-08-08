//
//  FXW_TextField.m
//  Sanhe
//
//  Created by kenshin on 17/3/14.
//  Copyright © 2017年 M2Mkey. All rights reserved.
//

#import "FXW_TextField.h"

@interface FXW_TextField()<UITextFieldDelegate>

/**
 设置该属相 可以限制文本框输入内容的长度
 */
@property (nonatomic, assign) NSInteger                         limitLen;

@property (nonatomic, copy)   FXW_TextFieldBlock                limitCallback;

@property (nonatomic, copy)   FXW_TextFieldBlock                edittingCallback;

@property (nonatomic, copy)   FXW_TextFieldBlock                searchingCallback;

@property (nonatomic, copy)   FXW_TextFieldBlock                begainingEditCallback;


@end

@implementation FXW_TextField

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self awakeFromNib];
    }
    return self;
}


//当使用xib加载的时候会调用该方法
- (void) awakeFromNib
{
    [super awakeFromNib];
    
    //添加事件监听
    [self addTarget:self
             action:@selector(textChangingValue:)
   forControlEvents:UIControlEventEditingChanged];
    
}

//编辑文本时会触发这里的方法 如果有设置文本的长度以下方法会对编辑文本进行裁剪，只保留设置长度的字符串
- (void) textChangingValue:(FXW_TextField *)textField
{
    if (_edittingCallback)//文本框内容改变时的回调
    {
        _edittingCallback(self);
    }
    
    
    if (_limitLen > 0)
    {
        NSUInteger len = textField.text.length;
        if (len > _limitLen)
        {
            self.text = [textField.text substringToIndex:_limitLen];//从0开始取
            if (_limitCallback)//文本框内容达到指定长度时的回调
            {
                _limitCallback(self);
            }
        }
    }
    
}

- (void)setLimitLen:(NSInteger)len andWithResultBlock:(FXW_TextFieldBlock )block
{
    _limitLen = len;
    _limitCallback = block;
    
}

- (void)textEdittingWithResultBlock:(FXW_TextFieldBlock )block
{
    _edittingCallback = block;
    
}

#pragma mark 文本框代理 监听软键盘的搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_searchingCallback)
    {
        _searchingCallback(self);
    }
    return YES;
    
}


//文本框进入编辑状态时触发
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_begainingEditCallback)
    {
        _begainingEditCallback(self);
    }
    return YES;
    
}

- (void)searchingWithResultBlock:(FXW_TextFieldBlock )block
{
    self.returnKeyType = UIReturnKeySearch;
    self.delegate = self;//为了 点击 搜索时候 触发 textFieldShouldReturn:
    _searchingCallback = block;
    
}

- (void)begainEditWithResultBlock:(FXW_TextFieldBlock )block
{
    self.delegate = self;
    _begainingEditCallback = block;
    
}

#pragma mark 覆盖父类方法［缩进的效果］
//控制文本所在的的位置，左右缩 10[初始化 set上值的时候]
- (CGRect)textRectForBounds:(CGRect)bounds
{
    int margin = _leftMargin>0?_leftMargin:10;
    
    return CGRectInset(bounds, margin, 0);
    
}

//控制编辑文本时所在的位置，左右缩 10[编辑的时候]
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    int margin = _leftMargin>0?_leftMargin:10;
    
    return CGRectInset(bounds, margin, 0);
    
}

@end
