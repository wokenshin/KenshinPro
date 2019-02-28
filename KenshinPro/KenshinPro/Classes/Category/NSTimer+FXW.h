//
//  NSTimer+FXW.h
//  KenshinPro
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (FXW)

//在阅读《Effective Objective-C 2.0》之前一直都没这么干过 很好的方式！
+ (NSTimer *)fxw_timerWithInterval:(NSTimeInterval)interval
                             block:(void(^)(void))block
                           repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
