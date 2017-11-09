//
//  CellLockCtrl.h
//  SmartApt
//
//  Created by kenshin on 2017/10/17.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockCtrlModel.h"

@interface CellLockCtrl : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView      *myCell;

@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;

@property (weak, nonatomic) IBOutlet UILabel     *labTitle;

@property (nonatomic, strong) LockCtrlModel      *model;

@end
