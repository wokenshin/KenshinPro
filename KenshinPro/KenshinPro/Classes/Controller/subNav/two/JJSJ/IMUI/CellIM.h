//
//  CellIM.h
//  KenshinPro
//
//  Created by kenshin van on 2018/2/2.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMModel.h"

@interface CellIM : UITableViewCell

@property (nonatomic, strong) IMModel   *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
