//
//  NSDate+FXW.h
//  KenshinPro
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FXW)

//定义 日期格式枚举
typedef NS_ENUM(NSInteger, FXW_DateFromatter) {
    FXW_DateFormatter_YMD      = 0,//如 2018-05-08
    FXW_DateFormatter_YMD2     = 1,//如 2018.05.08
    FXW_DateFormatter_YMD_HM   = 2,//如 2018-05-08 12:30
    FXW_DateFormatter_YMD2_HM  = 3,//如 2018.05.08 12:30
    FXW_DateFormatter_YMD_HMS  = 4,
    FXW_DateFormatter_YMD2_HMS = 5,
    FXW_DateFormatter_HM       = 6,//12:30
};


/**
 获取当前设备时间 毫秒级

 @return 时间戳
 */
+ (long)fxw_cuSystemTime;

/**
 是否是今天

 @return 真假
 */
- (BOOL)fxw_isToday;

/**
 是否是昨天

 @return 真假
 */
- (BOOL)fxw_isYesterday;

/**
 是否在同一周

 @return 真假
 */
- (BOOL)fxw_isSameWeek;

/**
 格式化NSDate为 年月日

 @return NSDate
 */
- (NSDate *)fxw_dateWithYMD;

/**
 时间戳转NSDate

 @param timespan 时间戳 注意 这里接收的是秒 而不是毫秒
 @return NSDate
 */
+ (NSDate *)fxw_timespanToDate:(long)timespan;

/**
 将NSDate转还成时间字符串 比如 2018-05-07 08:48:50

 @param type 时间字符串类型枚举
 @return 时间字符串
 */
- (NSString *)fxw_dateToStringWithFormat:(FXW_DateFromatter)type;

/**
 返回星期几

 @return 星期几
 */
- (NSString *)fxw_weekStr;

/**
 根据时间戳返回 刚刚 今天12:30 昨天， 星期几 2015.05.23 等字符串

 @param timespan 时间戳 秒级别
 @return 时间字符串
 */
+ (NSString *)fxw_wxsjWithTimespan:(long)timespan;

@end
