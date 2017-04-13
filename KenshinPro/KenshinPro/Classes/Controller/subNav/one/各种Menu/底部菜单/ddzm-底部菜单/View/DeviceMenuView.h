//
//  DeviceMenuView.h
//  Sanhe
//
//  Created by kenshin on 16/11/11.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置代理的第一步
@class DeviceMenuView;

@protocol DeviceMenuViewDelegate <NSObject>

@optional

//常用、快捷、编辑、删除[下一个版本再用 目前不用了 2016-11-28]
-(void)deviceMenuSetCommon:(DeviceMenuView *)itemView;
-(void)deviceMenuSetQuick:(DeviceMenuView *)itemView;
-(void)deviceMenuSetName:(DeviceMenuView *)itemView;
-(void)deviceMenuDelete:(DeviceMenuView *)itemView;

@end

@interface DeviceMenuView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnCommon;

@property (weak, nonatomic) IBOutlet UIButton *btnQuick;

@property (weak, nonatomic) IBOutlet UILabel *blueToothAddress;

@property (weak, nonatomic) IBOutlet UILabel  *title;

//设置代理的第二步
@property (nonatomic, weak) id<DeviceMenuViewDelegate> delegate;

@end
