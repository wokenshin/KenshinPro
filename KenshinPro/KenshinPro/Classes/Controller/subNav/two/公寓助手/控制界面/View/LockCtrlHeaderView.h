//
//  LockCtrlHeaderView.h
//  SmartApt
//
//  Created by kenshin on 2017/10/17.
//  Copyright © 2017年 m2mKey. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LockCtrlHeaderView : UIView


@property (weak, nonatomic) IBOutlet UILabel         *labXQName;
@property (weak, nonatomic) IBOutlet UILabel         *labAddress;
@property (weak, nonatomic) IBOutlet UILabel         *labMac;
@property (weak, nonatomic) IBOutlet UILabel         *labPlatform;
@property (weak, nonatomic) IBOutlet UILabel         *labName;
@property (weak, nonatomic) IBOutlet UILabel         *labBatery;
@property (weak, nonatomic) IBOutlet UIImageView     *imgBattery;


typedef void (^Block_LockCtrlHeaderView)(LockCtrlHeaderView *view);


//点击电池图片
- (void)clickBaterryViewWithResultBlock:(Block_LockCtrlHeaderView)block;


@end
