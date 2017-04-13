//
//  AppDelegate.h
//
//  Created by MCL on 16/7/13.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuActionBlock)(NSString *);

@interface LeftMenuTableView : UITableView

@property (nonatomic, copy) MenuActionBlock menuActionBlock;

@end
