//
//  CellJJSJYY.h
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelYY.h"

@interface CellJJSJYY : UICollectionViewCell
extern int const Height_CellJJSJYY;


@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic , strong) ModelYY *model;

@end
