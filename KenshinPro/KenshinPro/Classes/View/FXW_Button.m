//
//  UIButtonK.m
//  GYBase
//
//  Created by doit on 16/5/13.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FXW_Button.h"
#import "Tools.h"

@interface FXW_Button()

@property (nonatomic, copy) FXW_ButtonBlock             clickButtonCallback;

@end

@implementation FXW_Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //可以给不同的事件 设置不同的block
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}

- (void)clickAction
{
    if (_clickButtonCallback)
    {
        _clickButtonCallback(self);
    }
    
}

- (void)clickButtonWithResultBlock:(FXW_ButtonBlock)block
{
    _clickButtonCallback = block;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
