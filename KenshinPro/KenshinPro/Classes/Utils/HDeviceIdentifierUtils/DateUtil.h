//
//  DateUtil.h
//  server
//
//  Created by xiangwl on 15/12/23.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+(NSString *)dateToString:(NSDate *)date;
+(NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat;
+(NSDate *)stringToDate:(NSString *)strDate;
+(NSDate *)stringToDate:(NSString *)strDate dateFormat:(NSString *)dateFormat;
+(long)stringToTimespan:(NSString *)strDate dateFormat:(NSString *)dateFormat;
+(long)dateToTimespan;

+(NSDate *)timespanToDate:(long)timespan;

+(NSString *)timespanToStringDate:(long)timespan dateFormat:(NSString *)dateFormat;

//传入long 返回 年:月:日:时:分:秒
+ (NSString *)longToString:(long)times;

//传入long 返回 时:分
+ (NSString *)longToString24:(long)times;

//传入long 返回 年:月:日
+ (NSString *)longToStringYMD:(long)times;

//获取当前设备时间
+ (NSString *)cuDeviceTime;
@end
