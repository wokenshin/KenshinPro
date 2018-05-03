//
//  CellJJFriend.m
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CellJJFriend.h"
#import "Masonry.h"

@interface CellJJFriend()

@property (nonatomic, strong) UIImageView *imgHead;
@property (nonatomic, strong) UILabel     *labTitle;
@end;

@implementation CellJJFriend

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubView];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)initSubView
{
    WS(ws);
    _imgHead = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgHead];
    [_imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    _labTitle = [[UILabel alloc] init];
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.imgHead.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
}


- (void)setModel:(JJModelFriend *)model
{
    _model = model;
    _imgHead.image = [UIImage imageNamed:model.imgName];
    _labTitle.text = model.title;
}

@end
