//
//  VCView.h
//  KenshinPro
//
//  Created by kenshin on 17/4/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCView : UIView

typedef void (^VCViewBlock)(VCView *view);


/**
 点击xib中按钮的监听方法

 @param block 点击按钮时的回调
 */
- (void)clickButtonWithResultBlock:(VCViewBlock)block;


/**
 黄色按钮方法回调

 @param block 点击按钮时的回调
 */
- (void)clickButtonNextPage:(VCViewBlock)block;
@end
