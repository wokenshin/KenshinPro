//
//  MenuTableViewCell.m
//
//  Created by MCL on 16/7/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "Tools.h"

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //这个地方如果不加这个label的UI的话 当点击某一个cell的时候 这个cell上面的分割线会消失 下面的分割线会出现。。。。 无语
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 49)];
        [self.contentView addSubview:lable];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, screenWidth, 1)];
        _line.backgroundColor = colorLine;
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)setIsShowSeparatorLine:(BOOL)isShowSeparatorLine
{
    _isShowSeparatorLine = isShowSeparatorLine;
    if (isShowSeparatorLine)
    {
        _line.hidden = NO;
    }
    else
    {
        _line.hidden = YES;
    }

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGPoint cen = self.imageView.center;
    CGRect rect = self.imageView.frame ;
    rect.size = CGSizeMake(15.f, 15.f);
    self.imageView.frame = rect;
    self.imageView.center = cen;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}
@end
