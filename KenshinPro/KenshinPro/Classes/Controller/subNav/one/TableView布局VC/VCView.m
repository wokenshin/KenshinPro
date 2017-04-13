//
//  VCView.m
//  KenshinPro
//
//  Created by kenshin on 17/4/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCView.h"

@interface VCView()

@property (nonatomic, copy) VCViewBlock             clickButtonCallback;

@end

@implementation VCView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (IBAction)clickButton:(id)sender
{
    if (_clickButtonCallback)
    {
        _clickButtonCallback(self);
    }
    
}

- (void)clickButtonWithResultBlock:(VCViewBlock)block
{
    _clickButtonCallback = block;
    
}

- (IBAction)clickNextPage:(id)sender
{
    if (_clickButtonCallback)
    {
        _clickButtonCallback(self);
    }
    
}

- (void)clickButtonNextPage:(VCViewBlock)block
{
    _clickButtonCallback = block;
}

@end
