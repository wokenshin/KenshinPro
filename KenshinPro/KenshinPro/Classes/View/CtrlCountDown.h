//
//  CtrlCountDown.h
//  Sanhe
//
//  Created by kenshin on 16/11/22.
//  Copyright © 2016年 M2Mkey. All rights reserved.
//

#import "MDButton.h"//代码写的有点垃圾 不推荐使用了，建议使用FXW_CountDownButton

@interface CtrlCountDown : MDButton         //这是一个倒计时按钮 使用的时候必须调用setCountDownTime
                                            //必须调用closeCountDown
/**
 * 设置倒计时时间 必须设置，不然不会有倒计时的效果
 */
- (void)setCountDownTime:(NSInteger)time;

/**
 * 开启倒计时
 */
- (void)startCountDown;

/**
 * 关闭倒计时 必须调用 不然会占用资源
 */
- (void)closeCountDown;

/**
 * 是否正在倒计时
 */
- (BOOL)isCountingDown;

@end
