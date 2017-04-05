//
//  CellOrderWaitting.m
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CellOrderWaitting.h"
#import "Tools.h"

@interface CellOrderWaitting()

@property (nonatomic, copy) CellOrderWaittingBlock              clickBtnCallback;

@end

@implementation CellOrderWaitting

int const Height_CellOrderWaitting   = 100;


- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setModel:(ModelOrderWaitting *)model
{
    _model = model;
    
    _labDate.text = model.date;
    _labName.text = model.name;
    _labAddress.text = model.address;
    _labFixContent.text = model.fixContent;
    
    [Tools setFilletWithView:_btnAcceptOrder andAngle:_btnAcceptOrder.frame.size.width/2.0];
    
}

- (IBAction)clickBtnAcceptOrder:(id)sender
{
    if (_clickBtnCallback)
    {
        _clickBtnCallback(self);
    }
    
}

- (void)clickAcceptOrderButton:(CellOrderWaittingBlock)resultBlock
{
    _clickBtnCallback = resultBlock;
    
}

@end
