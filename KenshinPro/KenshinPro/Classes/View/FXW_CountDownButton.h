//
//  FXW_CountDownButton.h
//  KenshinPro
//
//  Created by kenshin on 17/5/17.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 关于资源释放的问题：不用外界手动调用[timer invalidate]; 
 由于定时器开启之后 倒计时到0时 就会调用[timer invalidate]，及时在界面pop之后也一样。到时候资源就可以自动释放了
 */
@interface FXW_CountDownButton : UIButton


/**
 设置倒计时时间 不设置的话 模式是60s
 */
@property (nonatomic, assign) NSInteger     countDownSecond;

/**
 定义代码块

 @param isStartCounting 开始倒计时
 @param isCounting      正在倒计时
 */
typedef void (^FXW_CountDownButtonBlock)(BOOL isStartCounting, BOOL isCounting);


/**
 点击事件回调
 
 @param block FXW_CountDownButtonBlock
 */
- (void)clickButtonWithResultBlock:(FXW_CountDownButtonBlock)block;


/**
 如果想要提前关闭定时器 可以调用该方法。不是必要的操作
 */
- (void)cleanTimer;

@end
