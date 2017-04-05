//
//  CellOrderCtrling.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CellOrderCtrling.h"
#import "FXW_Define.h"

@interface CellOrderCtrling()

@property (nonatomic, copy) CellOrderCtrlingBlock              clickBtnCallback;

@end


@implementation CellOrderCtrling

int const Height_CellOrderCtrling   = 130;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setModel:(ModelOrderCtrling *)model
{
    _model = model;
    
    if (model.orderStatus == 2)//处理中
    {
        _btnOverOrder.backgroundColor = colorHomeBlue;
        _btnOverOrder.enabled = YES;
    }
    else if(model.orderStatus == 3)//已经完成
    {
        _btnOverOrder.backgroundColor = RGB2Color(210, 208, 208);
        _btnOverOrder.enabled = NO;
    }
    
    _labOrderNo.text = model.orderNo;
    _labName.text = model.name;
    _labAddress.text = model.address;
    
}

- (IBAction)clickBtnOverOrder:(id)sender
{
    if (_clickBtnCallback)
    {
        _clickBtnCallback(self);
    }
    
}

- (void)clickOverOrderButton:(CellOrderCtrlingBlock)resultBlock
{
    _clickBtnCallback = resultBlock;
    
}


@end
