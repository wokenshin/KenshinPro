//
//  CellFXWTableMenu.m
//  CleverApartment
//
//  Created by kenshin on 2017/6/8.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import "CellFXWTableMenu.h"

@implementation CellFXWTableMenu

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setTitle:(NSString *)title
{
    _labTitle.text = title;
    
}
@end
