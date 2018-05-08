//
//  NSDate+FXW.m
//  KenshinPro
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "NSDate+FXW.h"
/*
 参考:https://blog.csdn.net/codermy/article/details/54233754
 
 */
@implementation NSDate (FXW)


+ (long)fxw_cuSystemTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;//*1000 为 毫秒
    return (long) time;
}

//是刚刚？ 5分钟以内
- (BOOL)fxw_isJustNow
{
    NSDate *cuOSDate = [NSDate date];
    NSTimeInterval timeCuOS = [cuOSDate timeIntervalSince1970];
    NSTimeInterval timeSelf = [self timeIntervalSince1970];
    NSTimeInterval timeLen  = 60*5;//5分钟时间间隔
    if (fabs(timeCuOS - timeSelf) < timeLen) {
        return YES;
    }
    
    return NO;
    
}

- (BOOL)fxw_isToday
{
    /*
     logic:比较 self 和 当前系统的 年月日 是否相同
     */
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];//1.获得当前时间的 年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];//2.获得self
    
    BOOL isToday = NO;
    if ((selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day)) {
        isToday = YES;
    }
    return isToday;

}

- (BOOL)fxw_isYesterday
{
    /*
     logic:与当前系统时间 相差一天 就返回 YES
     */
    NSDate *nowDate  = [[NSDate date] fxw_dateWithYMD];//2018-05-07
    NSDate *selfDate = [self fxw_dateWithYMD];//xxxx-xx-xx
    
    //获得nowDate和selfDate的差距
    NSCalendar *calendar   = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    BOOL isYesterday       = cmps.day == 1;
    return isYesterday;
}

- (BOOL)fxw_isSameWeek
{
    /*
     logic: 比较 self 和 当前系统的 年月周 是否相同
     bug:会多出一天 即把超出7天后的第八天也返回YES了
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];//转换时区为本地时区
    
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;

    NSDateComponents *nowCmps  = [calendar components:unit fromDate:[NSDate date]];//1.获得当前时间的 年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];//2.获得self
    
    BOOL isSameWeek = NO;
    if ((selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day)) {
        isSameWeek = YES;
    }
    
    return isSameWeek;
}

//格式化
- (NSDate *)fxw_dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat       = @"yyyy-MM-dd";
    NSString *selfStr    = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

+ (NSDate *)fxw_timespanToDate:(long)timespan
{
    return [NSDate dateWithTimeIntervalSince1970:timespan];//秒
}

- (NSString *)fxw_dateToStringWithFormat:(FXW_DateFromatter)type
{
    NSString *strDateFormat = @"";
    switch (type) {
        case FXW_DateFormatter_YMD:{
            strDateFormat = @"yyyy-MM-dd";
        }
            break;
        case FXW_DateFormatter_YMD2:{
            strDateFormat = @"yyyy.MM.dd";
        }
            break;
        case FXW_DateFormatter_YMD_HM:{
            strDateFormat = @"yyyy-MM-dd HH:mm";
        }
            break;
        case FXW_DateFormatter_YMD2_HM:{
            strDateFormat = @"yyyy.MM.dd HH:mm";
        }
            break;
        case FXW_DateFormatter_YMD_HMS:{
            strDateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
            break;
        case FXW_DateFormatter_YMD2_HMS:{
            strDateFormat = @"yyyy.MM.dd HH:mm:ss";
        }
            break;
        case FXW_DateFormatter_HM:{
            strDateFormat = @"HH:mm";
        }
            break;
        default:{
            strDateFormat = @"yyyy.MM.dd HH:mm";
        }
            break;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = strDateFormat;//设置日期格式
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//转换时区为本地时区
    NSString *dateAndTime = [dateFormatter stringFromDate:self];
    return dateAndTime;
    
}

//根据日期求星期几
- (NSString *)fxw_weekStr
{
    /*
     logic:以一周为单位 判断当前时间self 是否在周内 注意 这里的一周是指7天 而不是 星期
     */
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],
                         @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];//转换时区为本地时区
    
    NSCalendarUnit calendarUnit     = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    NSInteger index = theComponents.weekday;
    return [weekdays objectAtIndex:index];
    
}

+ (NSString *)fxw_wxsjWithTimespan:(long)timespan
{
    NSDate *date = [NSDate fxw_timespanToDate:timespan];
    
    if ([date fxw_isJustNow]) {
        return @"刚刚";
    }
    if ([date fxw_isToday]) {//今天 返回 12:30
        NSString *strDate  = [date fxw_dateToStringWithFormat:FXW_DateFormatter_HM];
        return strDate;
    }
    else if([date fxw_isYesterday]){//昨天 返回 昨天
        return @"昨天";
    }
    else if([date fxw_isSameWeek]){//一周内 返回 星期几
        NSString *weekX   = [date fxw_weekStr];
        NSString *cuWeekX = [[NSDate date] fxw_weekStr];
        if (![weekX isEqualToString:cuWeekX]) {//这样判断的目的是屏蔽掉 fxw_isSameWeek 中的一个bug 详情查看方法
            return weekX;
        }
    }
    //返回日期
    NSString *strDate = [[NSDate fxw_timespanToDate:timespan] fxw_dateToStringWithFormat:FXW_DateFormatter_YMD2_HMS];
    return strDate;
    
}





@end
