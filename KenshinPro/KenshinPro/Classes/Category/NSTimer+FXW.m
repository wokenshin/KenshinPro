//
//  NSTimer+FXW.m
//  KenshinPro
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "NSTimer+FXW.h"

@implementation NSTimer (FXW)

+ (NSTimer *)fxw_timerWithInterval:(NSTimeInterval)interval
                             block:(void(^)(void))block
                           repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(fxw_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:YES];
    
}

//注意这里也是一个类方法
+ (void)fxw_blockInvoke:(NSTimer*)timer{
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
