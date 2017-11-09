//
//  LockCtrlHeaderView.m
//  SmartApt
//
//  Created by kenshin on 2017/10/17.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import "LockCtrlHeaderView.h"

@interface LockCtrlHeaderView()

@property (nonatomic, copy) Block_LockCtrlHeaderView            block;

@end;

@implementation LockCtrlHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSString *nibName = NSStringFromClass([self class]);
        self = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil].firstObject;
        self.frame = frame;
        
        //适配
        if (screenWidth == screenWith5)
        {
            _labMac.font = FontK(16);
        }
        
        //添加手势事件
        UITapGestureRecognizer *greenViewClickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
        self.imgBattery.userInteractionEnabled = YES;
        [self.imgBattery addGestureRecognizer:greenViewClickTap];
        
    }
    return self;
    
}

//为UI赋值
//- (void)setModel:(RespMainInfo *)model
//{
//    _model = model;
//
//    NSString *building = model.building;
//    NSString *unit     = model.unit;
//    NSString *door     = model.door;
//    NSString *room     = model.room;
//    NSString *address  = [NSString stringWithFormat:@"%@%@%@%@",building, unit, door, room];
//
//    _labXQName.text    = model.district;
//    _labAddress.text   = address;
//    _labMac.text       = model.mac;
//    _labPlatform.text  = model.companyName;
//    _labName.text      = model.name;
//    _labBatery.text    = @"未获取";
//}

- (void)clickAction
{
    if (_block) {
        _block(self);
    }
}

- (void)clickBaterryViewWithResultBlock:(Block_LockCtrlHeaderView)block
{
    _block = block;
}

@end
