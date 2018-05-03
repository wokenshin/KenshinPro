//
//  CellJJSJMenu.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CellJJSJMenu.h"

int const Height_CellJJSJMenu = 80;

@implementation CellJJSJMenu

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ModelItem *)model
{
    _model = model;
    
    _imgView.image = [UIImage imageNamed:model.imgName];
    _labTitle.text = model.title;
    
}
@end
