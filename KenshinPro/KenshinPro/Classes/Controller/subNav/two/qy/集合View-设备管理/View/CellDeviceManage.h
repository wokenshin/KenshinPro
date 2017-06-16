//
//  CellDeviceManage.h
//  CleverApartment
//
//  Created by kenshin on 2017/6/9.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDeviceManage : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;

//适配
//通过约束来设置 圆形图片的宽高，其实可以使用比例来实现更简单，后期优化
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;


typedef void (^CellDeviceManageBlock)(CellDeviceManage *cell);

- (void)clickCell:(CellDeviceManageBlock)block;

@end
