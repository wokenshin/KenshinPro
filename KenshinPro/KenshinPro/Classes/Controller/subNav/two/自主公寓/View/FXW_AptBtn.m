//
//  FXW_AptBtn.m
//  AptLandlord
//
//  Created by kenshin on 2017/7/28.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import "FXW_AptBtn.h"

@interface FXW_AptBtn()


@property (weak, nonatomic) IBOutlet UIButton       *btnTitle;

@property (weak, nonatomic) IBOutlet UIImageView    *imgView;

@property (weak, nonatomic) IBOutlet UIView         *rightView;

@property (nonatomic, copy) FXW_AptBtnBlock         callback;

@end

@implementation FXW_AptBtn

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
        [self setTitle:title imgName:imgName];
    }
    return self;
    
}

- (void)setTitle:(NSString *)title imgName:(NSString *)imgName
{
    NSString *btnName = [NSString stringWithFormat:@"   %@", title];
    [_btnTitle setTitle:btnName forState:UIControlStateNormal];
    _imgView.image = [UIImage imageNamed:imgName];
    
}

- (IBAction)clickBtn:(id)sender
{
    if (_callback) {
        _callback(self);
    }
}

- (void)click:(FXW_AptBtnBlock)block
{
    self.callback = block;
}

@end
