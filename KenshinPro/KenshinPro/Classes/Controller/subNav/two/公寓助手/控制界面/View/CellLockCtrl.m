//
//  CellLockCtrl.m
//  SmartApt
//
//  Created by kenshin on 2017/10/17.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import "CellLockCtrl.h"

@implementation CellLockCtrl

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setModel:(LockCtrlModel *)model
{
    _model = model;
    
    _imgLeft.image = [UIImage imageNamed:model.imgName];
    _labTitle.text = model.title;
    
    self.layer.shadowColor   = [UIColor blackColor].CGColor;//在cell上加阴影
    self.layer.shadowOpacity = 0.6f;//阴影的透明度
    self.layer.shadowRadius  = 3.f;//阴影的圆角
    self.layer.shadowOffset  = CGSizeMake(0, 1);//阴影偏移量
    self.alpha               = 0.7;
    
    //适配
    if (screenWidth == screenWith5)
    {
        _labTitle.font = FontK(16);
    }
    
}

@end
