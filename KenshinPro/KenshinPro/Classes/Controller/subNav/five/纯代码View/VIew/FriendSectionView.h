//
//  FriendSectionView.h
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendSectionView : UIView


/**
 返回view frame (0, 0, 屏宽, 40)

 @return FriendSectionView
 */
+ (FriendSectionView *)jjsj_create;

//定义代码块
typedef void (^BlockFriendSection)(FriendSectionView *obj);

//点击事件
- (void)click:(BlockFriendSection)resultBlock;

//长按事件
- (void)longPress:(BlockFriendSection)resultBlock;

@end
