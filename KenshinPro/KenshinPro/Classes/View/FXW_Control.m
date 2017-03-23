//
//  UIButtonK.m
//  GYBase
//
//  Created by doit on 16/4/22.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "FXW_Control.h"
#import "Tools.h"

@interface FXW_Control()

@property (nonatomic, copy)FXW_ControlBlock                     clickControlCallback;

@end

@implementation FXW_Control

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
    if (_clickControlCallback)
    {
        _clickControlCallback(self);    
    }
    
}

- (void)clickControlWithResultBlock:(FXW_ControlBlock)block
{
    _clickControlCallback = block;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
