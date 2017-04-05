//
//  CellOrderWaitting.h
//  SmartLockMaster
//
//  Created by kenshin on 17/3/29.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelOrderWaitting.h"

@interface CellOrderWaitting : UITableViewCell

//定义cell的高度
extern int const Height_CellOrderWaitting;

@property (nonatomic, strong) ModelOrderWaitting            *model;

@property (weak, nonatomic) IBOutlet UILabel *labDate;

@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@property (weak, nonatomic) IBOutlet UILabel *labFixContent;

@property (weak, nonatomic) IBOutlet UIButton *btnAcceptOrder;


typedef void (^CellOrderWaittingBlock)(CellOrderWaitting *cell);

- (void)clickAcceptOrderButton:(CellOrderWaittingBlock)resultBlock;

@end
