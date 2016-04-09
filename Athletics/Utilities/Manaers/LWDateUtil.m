//
//  LWDateUtil.m
//  Link
//
//  Created by 李宛 on 16/3/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import "LWDateUtil.h"

@implementation LWDateUtil

+(BOOL)isLeapYear:(NSInteger)year
{
    NSAssert(!(year < 1),  @"inalid year number");
    BOOL leap = FALSE;
    if ((0 == (year % 400))) {
        leap = TRUE;
    }else if ((0 == (year % 4)) && (0 != (year %100))){
        leap = TRUE;
    }
    return leap;
}
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month
{
    return [LWDateUtil numberOfDaysInMonth:month year:[LWDateUtil getCurrentYear]];
}

+ (NSInteger)getCurrentYear
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int year = dt->tm_year + 1900;
    return year;
}

+ (NSInteger)getCurrentMonth
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int month = dt->tm_mon + 1;
    return month;
}

+ (NSInteger)getCurrentDay
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int day = dt->tm_mday;
    return day;
}

+ (NSInteger)getCurrentHour
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int hour = dt->tm_hour;
    return hour;
}

+ (NSInteger)getCurrentMinute
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int minute = dt->tm_min;
    return minute;
}

+ (NSInteger)getYearWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger year = comps.year;
    return year;
}

+ (NSInteger)getMonthWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger month = comps.month;
    return month;
}

+ (NSInteger)getDayWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger day = comps.day;
    return day;
}

+ (NSInteger)getHourWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger hour = comps.hour;
    return hour;
}

+ (NSInteger)getMinuteWithDate:(NSDate*)date
{
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    NSInteger minute = comps.minute;
    return minute;
}

+ (NSInteger)weekDate:(NSDate*)date
{
    // 获取当前年月日和周几
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
        default:
            break;
    }
    
    return dayInt;
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year
{
    NSAssert(!(month < 1||month > 12), @"invalid month number");
    NSAssert(!(year < 1), @"invalid year number");
    month = month - 1;
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    NSInteger days = daysOfMonth[month];
    /*
     * feb
     */
    if (month == 1) {
        if ([LWDateUtil isLeapYear:year]) {
            days = 29;
        }
        else {
            days = 28;
        }
    }
    return days;
}

+ (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval
{
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval*24*60*60];
}

+ (NSString *)stringSinceDate:(NSString *)date
{
    NSDateFormatter *beFormatter  =[[NSDateFormatter alloc]init];
    [beFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeDate = [beFormatter dateFromString:date];
    NSTimeInterval timeout = [[NSDate date] timeIntervalSinceDate:beforeDate];
    NSString *timeString = @"";
    if (timeout < 60 * 60) {
        timeString = [NSString stringWithFormat:@"%d分钟前",(int)timeout/60];
        
    }else if (timeout < 60*60*24){
        timeString = [NSString stringWithFormat:@"%d小时前",(int)timeout/(60*60)];
        
    }else{
        timeString = [NSString stringWithFormat:@"%d天前",(int)timeout/(60*60*24)];
        
    }
    
    return timeString;
    
}

+ (NSString*)stringWithDate:(NSString *)date sinceDate:(NSString*)sinceDate
{
    NSDateFormatter *beFormatter  =[[NSDateFormatter alloc]init];
    [beFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeDate = [beFormatter dateFromString:date];
    NSDate *nowDate;
    if (sinceDate == nil) {
        nowDate = [NSDate date];
    }else{
        nowDate = [beFormatter dateFromString:sinceDate];
    }
    NSTimeInterval timeout = [nowDate timeIntervalSinceDate:beforeDate];
    NSString *timeString = @"";
    if (timeout < 60 * 60) {
        timeString = [NSString stringWithFormat:@"%d分钟前",(int)timeout/60];
        
    }else if (timeout < 60*60*24){
        timeString = [NSString stringWithFormat:@"%d小时前",(int)timeout/(60*60)];
        
    }else{
        timeString = [NSString stringWithFormat:@"%d天前",(int)timeout/(60*60*24)];
        
    }
    
    return timeString;
}

+ (NSDate *)getLocaDateFromStandardDate:(NSDate *)standardDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:standardDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:standardDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:standardDate];
    return destinationDateNow;
}

@end
