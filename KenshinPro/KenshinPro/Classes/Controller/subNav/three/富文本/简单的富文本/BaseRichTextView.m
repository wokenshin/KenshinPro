//
//  BaseRichTextView.m
//  KenshinPro
//
//  Created by kenshin on 17/4/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseRichTextView.h"

@interface BaseRichTextView()

@property (nonatomic, copy) BaseRichTextViewBlock           callback;

@end

@implementation BaseRichTextView

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
    if (_callback != nil)
    {
        _callback();
    }
}

- (void)clickButtonpPushNextVC:(BaseRichTextViewBlock)block
{
    _callback = block;
}

@end
