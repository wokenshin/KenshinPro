//
//  CellJJSJMenu.h
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelItem.h"


@interface CellJJSJMenu : UICollectionViewCell


extern int const Height_CellJJSJMenu;

@property (nonatomic , strong) ModelItem    *model;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;


@end
