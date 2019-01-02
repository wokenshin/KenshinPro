//
//  CellCusTwo.m
//  KenshinPro
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "CellCusTwo.h"

@interface CellCusTwo()

@property (nonatomic, strong) IBOutlet UILabel   *labName;
@property (nonatomic, strong) IBOutlet UILabel   *labColor;

@end

@implementation CellCusTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
