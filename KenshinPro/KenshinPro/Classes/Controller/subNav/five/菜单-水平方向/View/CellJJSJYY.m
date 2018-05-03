//
//  CellJJSJYY.m
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "CellJJSJYY.h"
#import "Tools.h"

int const Height_CellJJSJYY = 80;

@implementation CellJJSJYY

- (void)awakeFromNib {
    [super awakeFromNib];
    [Tools setCornerRadiusWithView:_imgView andAngle:6];
    
}

- (void)setModel:(ModelYY *)model
{
    _model = model;
    _imgView.image = [UIImage imageNamed:model.imgUrl];
    
}
@end
