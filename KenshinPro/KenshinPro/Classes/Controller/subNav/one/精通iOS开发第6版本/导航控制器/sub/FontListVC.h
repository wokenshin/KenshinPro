//
//  FontListVC.h
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontListVC : UITableViewController

@property (nonatomic, strong) NSArray            *fontNames;
@property (nonatomic, assign) BOOL               showsFavorites;
@property (nonatomic, assign) CGFloat            cellPointSize;

@end

NS_ASSUME_NONNULL_END
