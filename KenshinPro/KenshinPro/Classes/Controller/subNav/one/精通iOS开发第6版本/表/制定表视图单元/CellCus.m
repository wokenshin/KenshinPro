//
//  CellCus.m
//  KenshinPro
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "CellCus.h"

@interface CellCus()

@property (nonatomic, strong) UILabel   *labName;
@property (nonatomic, strong) UILabel   *labColor;

@end

@implementation CellCus

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化代码
        CGRect rectLabName = CGRectMake(0, 5, 70, 15);
        UILabel *nameMarker = [[UILabel alloc] initWithFrame:rectLabName];
        nameMarker.textAlignment = NSTextAlignmentRight;
        nameMarker.text = @"Name:";
        nameMarker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameMarker];
        
        CGRect rectColor = CGRectMake(0, 26, 70, 15);
        UILabel *colorMarker = [[UILabel alloc] initWithFrame:rectColor];
        colorMarker.textAlignment = NSTextAlignmentRight;
        colorMarker.text = @"Color:";
        colorMarker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorMarker];
        
        CGRect rectNameValue = CGRectMake(80, 5, 200, 15);
        _labName = [[UILabel alloc] initWithFrame:rectNameValue];
        [self.contentView addSubview:_labName];
        
        CGRect rectColorValue = CGRectMake(80, 25, 200, 15);
        _labColor = [[UILabel alloc] initWithFrame:rectColorValue];
        [self.contentView addSubview:_labColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setName:(NSString *)name{
    _name = name;
    _labName.text = name;
}

- (void)setColor:(NSString *)color{
    _color = color;
    _labColor.text = color;
}

@end
