//
//  FXW_ENUM.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXW_ENUM : NSObject

#pragma mark - 参考 可以写负数
typedef NS_ENUM(NSInteger, LOCK_TYPE)
{
    LOCK_TYPE_SLOCK1               = 4,
    LOCK_TYPE_SLOCK3               = 3,
    LOCK_TYPE_SLOCK2               = 5,
    
};

@end
