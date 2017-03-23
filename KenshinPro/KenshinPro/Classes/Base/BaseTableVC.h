//
//  BaseTableVC.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableVC : BaseVC<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView                   *tableView;

@property (nonatomic, strong) NSMutableArray                *mArrData;



/**
 添加数据到列表

 @param title 标题
 @param detail 详情
 */
- (void)addDataWithTitle:(NSString *)title andDetail:(NSString *)detail;


/**
 cell被点击的时候会调用该方法，子类通过重写该方法来实现监听

 @param title cell的 title
 */
- (void)clickCellWithTitle:(NSString *)title;

@end
