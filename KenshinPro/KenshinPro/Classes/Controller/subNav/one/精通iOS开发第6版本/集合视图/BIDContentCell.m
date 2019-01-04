//
//  BIDContentCell.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "BIDContentCell.h"

@implementation BIDContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化代码
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _label.opaque = NO;//不透明的
        _label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [[self class] defaultFont];
        [self.contentView addSubview:_label];
    }
    return self;
}

+ (UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (CGSize)sizeForContentString:(NSString *)string{
    CGSize maxSize = CGSizeMake(300, 1000);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName : [self defaultFont],
                                 NSParagraphStyleAttributeName : style};
    
    CGRect rect = [string boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    
    return rect.size;
    
}

-(NSString *)text{
    return _label.text;
}

- (void)setText:(NSString *)text{
    _label.text = text;
    CGRect newLableFrame = _label.frame;
    CGRect newContentFrmae = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text];
    newLableFrame.size = textSize;
    newContentFrmae.size = textSize;
    _label.frame = newLableFrame;
    self.contentView.frame = newContentFrmae;
}


@end
