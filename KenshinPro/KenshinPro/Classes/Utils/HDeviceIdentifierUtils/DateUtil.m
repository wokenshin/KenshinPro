//
//  DateUtil.m
//  server
//
//  Created by xiangwl on 15/12/23.
//  Copyright (c) 2015年 ddsl. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+(NSString *)dateToString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";// HH:mm"; // 设置时间和日期的格式yyyy-MM-dd HH:mm:ss
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}


+(NSString *)dateToString24:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm"; // 设置时间和日期的格式
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

+(NSString *)dateToStringYMD:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

+(NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat; // 设置时间和日期的格式
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateAndTime = [dateFormatter stringFromDate:date];
    return dateAndTime;
}

+(NSDate *)stringToDate:(NSString *)strDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm"; // 设置时间和日期的格式
    NSDate *date=[dateFormatter dateFromString:strDate];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSInteger fromInterval = [timeZone secondsFromGMTForDate:date];
    NSDate *fromDate = [date  dateByAddingTimeInterval: fromInterval];
    
    return fromDate;
}

+(NSDate *)stringToDate:(NSString *)strDate dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat; // 设置时间和日期的格式
    NSDate *date=[dateFormatter dateFromString:strDate];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSInteger fromInterval = [timeZone secondsFromGMTForDate:date];
    NSDate *fromDate = [date  dateByAddingTimeInterval: fromInterval];
    
    return fromDate;
}

+(long)stringToTimespan:(NSString *)strDate dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat; // 设置时间和日期的格式
    NSDate *date=[dateFormatter dateFromString:strDate];
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSInteger fromInterval = [timeZone secondsFromGMTForDate:date];
    NSDate *fromDate = [date  dateByAddingTimeInterval: fromInterval];
    
    return (long)[fromDate timeIntervalSince1970];
}

+(long)dateToTimespan{
    NSDate *date = [[NSDate alloc]init];
    NSString *strDate = [DateUtil dateToString:date];
    return [DateUtil stringToTimespan:strDate dateFormat:@"yyyy-MM-dd HH:mm"];
}

+(NSDate *)timespanToDate:(long)timespan{
    return [NSDate dateWithTimeIntervalSince1970:timespan];
}

+(NSString *)timespanToStringDate:(long)timespan dateFormat:(NSString *)dateFormat{
    NSDate * date = [DateUtil timespanToDate:timespan];
    return [DateUtil dateToString:date dateFormat:dateFormat];
}

//传入long 返回 年:月:日:时:分:秒
+ (NSString *)longToString:(long)times
{
    return [DateUtil dateToString:[DateUtil timespanToDate:times]];
    
}

//传入long 返回 年:月:日:时:分:秒
+ (NSString *)longToString24:(long)times
{
    return [DateUtil dateToString24:[DateUtil timespanToDate:times]];
    
}

//传入long 返回 年:月:日
+ (NSString *)longToStringYMD:(long)times
{
    return [DateUtil dateToStringYMD:[DateUtil timespanToDate:times]];
    
}

//获取当前设备时间
+ (NSString *)cuDeviceTime
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
    
}

@end
