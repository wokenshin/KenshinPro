//
//  CellDeviceManage.m
//  CleverApartment
//
//  Created by kenshin on 2017/6/9.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import "CellDeviceManage.h"
#import "Tools.h"

@interface CellDeviceManage()

@property (nonatomic, copy) CellDeviceManageBlock               callback;

@end

@implementation CellDeviceManage

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
    
}

- (void)setUp
{
    [Tools setFilletWithView:_backView andAngle:screenWidth/2/10.0];
    [Tools setBorder:_backView andColor:RGB2Color(230, 230, 230) andWeight:1];
    _backView.backgroundColor = [UIColor whiteColor];
    
    CGFloat sizeImg = screenWidth/2 * 0.5;
    _imgH.constant = sizeImg;
    _imgW.constant = sizeImg;
    
    //添加View手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(clickCell)];
    _backView.userInteractionEnabled = YES;
    [_backView addGestureRecognizer:tap];
    
}

- (void)clickCell
{
    //这里说明一下为什么要使用手势，因为margin的效果我是在cell中实现的，但是点击margin中间部分 cell的点击还是会响应
    //将margin的效果实现在cell中的原因是 这样设置最简单，不用去设置集合中的其他代理 cell的大小直接设置为 屏宽/个数 即可
    if (_callback)
    {
        _callback(self);
    }
    
}

- (void)clickCell:(CellDeviceManageBlock)block
{
    self.callback = block;
}

@end
