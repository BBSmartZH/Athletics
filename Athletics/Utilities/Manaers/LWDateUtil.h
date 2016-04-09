//
//  LWDateUtil.h
//  Link
//
//  Created by 李宛 on 16/3/9.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LWDateUtil : NSObject

+ (BOOL)isLeapYear:(NSInteger)year;
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month;
+ (NSInteger)getCurrentYear;
+ (NSInteger)getCurrentMonth;
+ (NSInteger)getCurrentDay;
+ (NSInteger)getCurrentHour;
+ (NSInteger)getCurrentMinute;
+ (NSInteger)getYearWithDate:(NSDate*)date;
+ (NSInteger)getMonthWithDate:(NSDate*)date;
+ (NSInteger)getDayWithDate:(NSDate*)date;
+ (NSInteger)getHourWithDate:(NSDate*)date;
+ (NSInteger)getMinuteWithDate:(NSDate*)date;
+ (NSInteger)weekDate:(NSDate*)date;
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year;
+ (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval;
+ (NSString*)stringWithDate:(NSString *)date sinceDate:(NSString*)sinceDate;
+ (NSDate *)getLocaDateFromStandardDate:(NSDate *)standardDate;


@end
