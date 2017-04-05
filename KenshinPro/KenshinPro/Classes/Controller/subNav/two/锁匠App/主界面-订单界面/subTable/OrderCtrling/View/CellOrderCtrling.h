//
//  CellOrderCtrling.h
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelOrderCtrling.h"

@interface CellOrderCtrling : UITableViewCell

extern int const Height_CellOrderCtrling;

@property (nonatomic, strong) ModelOrderCtrling             *model;

@property (weak, nonatomic) IBOutlet UILabel *labOrderNo;

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@property (weak, nonatomic) IBOutlet UIButton *btnOverOrder;


typedef void (^CellOrderCtrlingBlock)(CellOrderCtrling *cell);

- (void)clickOverOrderButton:(CellOrderCtrlingBlock)resultBlock;
@end
