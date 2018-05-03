//
//  JJCircleView.h
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJCircleView : UIView

/**
 返回view frame为 (0, 0 , 屏宽, 150)

 @return JJCircleView
 */
+ (JJCircleView *)jjsj_createJJCircleView;

typedef void (^BlockJJCircleView)(JJCircleView *view);


/**
 点击群cell

 @param resultBlock 回调
 */
- (void)clickGroupCell:(BlockJJCircleView)resultBlock;

/**
 点击房间cell

 @param resultBlock 回调
 */
- (void)clickRoomCell:(BlockJJCircleView)resultBlock;

@end
