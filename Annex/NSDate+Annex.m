//
//  NSDate+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSDate+Annex.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Annex)
@dynamic nearestHour;
@dynamic hour;
@dynamic minute;
@dynamic seconds;
@dynamic day;
@dynamic month;
@dynamic week;
@dynamic weekday;
@dynamic nthWeekday;
@dynamic year;

+ (NSDate *)firstDayOfCurrentMonth
{
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDateComponents *components    = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:1];

    return [calendar dateFromComponents:components];
}

+ (NSDate *)firstDayOfCurrentMonthWithCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components    = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [components setDay:1];

    return [calendar dateFromComponents:components];
}

+ (NSDate *)lastDayOfCurrentMonth
{
    NSDate *today                   = [NSDate date];
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDateComponents *components    = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    NSRange calendarRange           = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:components]];
    
    [components setDay:calendarRange.length];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *)lastDayOfCurrentMonthWithCalendar:(NSCalendar *)calendar
{
    NSDate *today                   = [NSDate date];
    NSDateComponents *components    = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    NSRange calendarRange           = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:components]];

    [components setDay:calendarRange.length];

    return [calendar dateFromComponents:components];
}

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexDay * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - AnnexDay * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexHour * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - AnnexHour * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexMinute * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - AnnexMinute * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) &&
			(components1.day == components2.day));
}

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate withCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [calendar components:DATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) &&
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTodayWithCalendar:(NSCalendar *)calendar
{
	return [self isEqualToDateIgnoringTime:[NSDate date] withCalendar:calendar];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isTomorrowWithCalendar:(NSCalendar *)calendar
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow] withCalendar:calendar];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL) isYesterdayWithCalendar:(NSCalendar *)calendar
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday] withCalendar:calendar];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.week != components2.week) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < AnnexWeek);
}

- (BOOL) isSameWeekAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [calendar components:DATE_COMPONENTS fromDate:aDate];

	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.week != components2.week) return NO;

	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < AnnexWeek);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isThisWeekWithCalendar:(NSCalendar *)calendar
{
	return [self isSameWeekAsDate:[NSDate date] withCalendar:calendar];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexWeek;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isNextWeekWithCalendar:(NSCalendar *)calendar
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexWeek;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate withCalendar:calendar];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - AnnexWeek;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeekWithCalendar:(NSCalendar *)calendar
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - AnnexWeek;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate withCalendar:calendar];
}

- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isSameMonthAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [calendar components:NSYearCalendarUnit fromDate:aDate];
	return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isThisMonthWithCalendar:(NSCalendar *)calendar
{
    return [self isSameMonthAsDate:[NSDate date] withCalendar:calendar];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [calendar components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isThisYearWithCalendar:(NSCalendar *)calendar
{
	return [self isSameYearAsDate:[NSDate date] withCalendar:calendar];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isNextYearWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [calendar components:NSYearCalendarUnit fromDate:[NSDate date]];

	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isLastYearWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components1 = [calendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [calendar components:NSYearCalendarUnit fromDate:[NSDate date]];

	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWeekendWithCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [calendar components:NSYearCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

- (BOOL) isTypicallyWorkdayWithCalendar:(NSCalendar *)calendar
{
    return ![self isTypicallyWeekendWithCalendar:calendar];
}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + AnnexDay * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + AnnexHour * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + AnnexMinute * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *) dateAtStartOfDayWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [calendar dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar
{
	NSDateComponents *dTime = [calendar components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / AnnexMinute);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / AnnexMinute);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / AnnexHour);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / AnnexHour);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / AnnexDay);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / AnnexDay);
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexMinute * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger) nearestHourWithCalendar:(NSCalendar *)calendar
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + AnnexMinute * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger) hourWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger) minuteWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger) secondsWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger) dayWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger) monthWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger) weekWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger) weekdayWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) nthWeekdayWithCalendar:(NSCalendar *)calendar // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.year;
}

- (NSInteger) yearWithCalendar:(NSCalendar *)calendar
{
	NSDateComponents *components = [calendar components:DATE_COMPONENTS fromDate:self];
	return components.year;
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;

    return [formatter dateFromString:string];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone   = timeZone;
    formatter.dateFormat = format;

    return [formatter dateFromString:string];
}

+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year
{
    return [NSDate dateWithMonth:month day:day year:year calendar:NSGregorianCalendar];
}

+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year withCalendar:(NSCalendar *)calendar
{
    NSDateComponents *dateComponents    = [[NSDateComponents alloc] init];
    dateComponents.year                 = year;
    dateComponents.month                = month;
    dateComponents.day                  = day;

    return [calendar dateFromComponents:dateComponents];
}

+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year calendar:(NSString *)calendar
{
    NSDateComponents *dateComponents    = [[NSDateComponents alloc] init];
    dateComponents.year                 = year;
    dateComponents.month                = month;
    dateComponents.day                  = day;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:calendar];
    
    return [cal dateFromComponents:dateComponents];
}

- (NSString *)humanDateSinceDate:(NSDate *)date
{
    NSString *(^componentStringBlock)(NSInteger, NSString *)  =  ^(NSInteger component, NSString *name) {
        return [NSString stringWithFormat:@"%d %@ ago", component, ((component == 1)? [name copy] : [NSString stringWithFormat:@"%@s", name])];
    };
    
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDate *before                  = [self earlierDate:date];
    NSDate *after                   = (before == self)? date : self;
    NSDateComponents *components    = [calendar components:(NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:before toDate:after options:0];
    NSString *result                = @"now";
    
    if(components.year >= 1)
        result = @"over a year";
    
    if(components.month >= 1)
        result = componentStringBlock(components.month, @"month");
    
    if(components.week >= 1)
        result = componentStringBlock(components.week, @"week");

    if(components.day >= 1)
        result = componentStringBlock(components.day, @"day");
    
    if(components.minute >= 1)
        result = componentStringBlock(components.minute, @"minute");

    return result;
}

- (NSString *)humanDateSinceNow
{
    return [self humanDateSinceDate:[NSDate date]];
}

+ (NSString *)humanDateSinceDate:(NSDate *)date
{
    return [[NSDate date] humanDateSinceDate:date];
}

+ (NSString *)humanDateFromDate:(NSDate *)date toDate:(NSDate *)toDate
{
    return [date humanDateSinceDate:date];
}

@end
