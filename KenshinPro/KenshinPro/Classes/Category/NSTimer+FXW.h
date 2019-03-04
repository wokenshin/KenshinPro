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


/**
 在阅读《Effective Objective-C 2.0》之前一直都没这么干过 很好的方式！
 知识点在书中的最后几页 P207

 有点：只要避免本方法中“块”的循环引用，就可以避免timer的循环引用 
 @param interval 时间间隔
 @param block 执行的任务
 @param repeats 是否重复
 @return timer
 */
+ (NSTimer *)fxw_timerWithInterval:(NSTimeInterval)interval
                             block:(void(^)(void))block
                           repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
