//
//  NSDate+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//
// Inspired by Erica Sadun's https://github.com/erica/NSDate-Extensions
//

#import <Foundation/Foundation.h>

#define AnnexMinute 60
#define AnnexHour   3600
#define AnnexDay    86400
#define AnnexWeek   604800
#define AnnexYear   31556926

@interface NSDate (Annex)
/**
 `NSDate(Annex)` is an extension to simplify working with dates.
 */

/**
 Provides a short cut to get to get the next, closest, hour.
 */
@property (readonly) NSInteger nearestHour;

/**
 Provides a short cut to get to get the next, closest, hour with a calendar.
 */
- (NSInteger)nearestHourWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's hour.
 */
@property (readonly) NSInteger hour;

/**
 Provides a short cut to get a date's hour with a calendar.
 */
- (NSInteger) hourWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's minute.
 */
@property (readonly) NSInteger minute;

/**
 Provides a short cut to get a date's minute with a calendar.
 */
- (NSInteger) minuteWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's seconds.
 */
@property (readonly) NSInteger seconds;

/**
 Provides a short cut to get a date's seconds with a calendar.
 */
- (NSInteger) secondsWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get date's day.
 */
@property (readonly) NSInteger day;

/**
 Provides a short cut to get date's day with a calendar.
 */
- (NSInteger) dayWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's month.
 */
@property (readonly) NSInteger month;

/**
 Provides a short cut to get a date's month with a calendar.
 */
- (NSInteger) monthWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's week.
 */
@property (readonly) NSInteger week;

/**
 Provides a short cut to get a date's week with a calendar.
 */
- (NSInteger) weekWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get to tomorrow's date object.
 */
@property (readonly) NSInteger weekday;

/**
 Provides a short cut to get to tomorrow's date object with a calendar.
 */
- (NSInteger) weekdayWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get to tomorrow's date object.
 
 @discuss 2nd Tuesday of the month == 2
 */
@property (readonly) NSInteger nthWeekday;

/**
 Provides a short cut to get to tomorrow's date object with a calendar.

 @discuss 2nd Tuesday of the month == 2
 */
- (NSInteger) nthWeekdayWithCalendar:(NSCalendar *)calendar;

/**
 Provides a short cut to get a date's year.
 */
@property (readonly) NSInteger year;

/**
 Provides a short cut to get a date's year with a calendar.
 */
- (NSInteger) yearWithCalendar:(NSCalendar *)calendar;

/**
 Gets first day of current month.
 
 @return First day of current month.
 */
+ (NSDate *)firstDayOfCurrentMonth;

/**
 Gets first day of current month with a calendar.

 @return First day of current month with a calendar.
 */
+ (NSDate *)firstDayOfCurrentMonthWithCalendar:(NSCalendar *)calendar;

/**
 Gets last day of current month.
 
 @return last day of current month.
 */
+ (NSDate *)lastDayOfCurrentMonth;

/**
 Gets last day of current month with a calendar.

 @return last day of current month with a calendar.
 */
+ (NSDate *)lastDayOfCurrentMonthWithCalendar:(NSCalendar *)calendar;

/**
 Gets tomorrow's date.
 
 @return        Tomorrow's date.
 */
+ (NSDate *) dateTomorrow;

/**
 Gets yesterday's date
 
 @return        Yesterday's date.
 */
+ (NSDate *) dateYesterday;

/**
 Adds given number of days to today.
 
 @param days    Number of days to add to current date.
 @return        New date with addition of days
 */
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;

/**
 Subtracts the number of days from today.
 
 @param days    Number of days to subtract from current date.
 @return        New date minus days.
 */
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;

/**
 Adds given number of hours to today.
 
 @param dHours      Number of hours to add to current date.
 @return            New date with addition of hours.
 */
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;

/**
 Subtracts the number of hours from today.
 
 @param dHours  Number of hours to subtract from current date.
 @return        New date minus hours.
 */
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;

/**
 Adds given number of minutes to today.
 
 @param dMinutes    Number of minutes to add to current date.
 @return            New date with addition of minutes.
 */
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;

/**
 Subtracts the number of minutes from today.
 
 @param dMinutes  Number of minutes to subtract from current date.
 @return          New date minus minutes.
 */
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;



/**
 Test to see if dates are equal, while ignoring their time.
 
 @param aDate   Date to compare current date with.
 @return        YES or NO based on the date comparison.
 */
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

/**
 Test to see if dates are equal, while ignoring their time with a calendar.

 @param aDate   Date to compare current date with.
 @return        YES or NO based on the date comparison.
 */
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate withCalendar:(NSCalendar *)calendar;

/**
 Test to see if two dates are between each other, inclusive.

 @param startDate Date to begin wtih.
 @param endDate   Date to end with.
 @return          YES if self is between startDate and endDate
 */
- (BOOL)isBetweenDate:(NSDate *)startDate and:(NSDate*)endDate;

/**
 Test to see if current date is today.
 
 @return YES or NO result from comparing current date, with today's date.
 */
- (BOOL) isToday;

/**
 Test to see if current date is today with a calendar.

 @return YES or NO result from comparing current date, with today's date.
 */
- (BOOL) isTodayWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is tomorrow.
 
 @return YES or NO result from comparing current date, with tomorrow's date.
 */
- (BOOL) isTomorrow;

/**
 Test to see if current date is tomorrow with a calendar.

 @return YES or NO result from comparing current date, with tomorrow's date.
 */
- (BOOL) isTomorrowWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is yesterday.
 
 @return YES or NO result from comparing current date, with yesterday's date.
 */
- (BOOL) isYesterday;

/**
 Test to see if current date is yesterday with a calendar.

 @return YES or NO result from comparing current date, with yesterday's date.
 */
- (BOOL) isYesterdayWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is in the same week as another date.
 
 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same week as aDate.
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;

/**
 Test to see if current date is in the same week as another date with a calendar.

 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same week as aDate.
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of this week.
 
 @return        YES or NO based on if current date is in this week.
 */
- (BOOL) isThisWeek;

/**
 Test to see if current date part of this week with a calendar.

 @return        YES or NO based on if current date is in this week.
 */
- (BOOL) isThisWeekWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of next week.
 
 @return        YES or NO based on if current date is in next week.
 */
- (BOOL) isNextWeek;

/**
 Test to see if current date part of next week with a calendar.

 @return        YES or NO based on if current date is in next week.
 */
- (BOOL) isNextWeekWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of last week.
 
 @return        YES or NO based on if current date is in last week.
 */
- (BOOL) isLastWeek;

/**
 Test to see if current date part of last week with a calendar.

 @return        YES or NO based on if current date is in last week.
 */
- (BOOL) isLastWeekWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is in the same month as another date.
 
 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same month as aDate.
 */
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;

/**
 Test to see if current date is in the same month as another date with a calendar.

 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same month as aDate.
 */
- (BOOL) isSameMonthAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of this month.
 
 @return        YES or NO based on if current date is in this month.
 */
- (BOOL) isThisMonth;

/**
 Test to see if current date part of this month with a calendar.

 @return        YES or NO based on if current date is in this month.
 */
- (BOOL) isThisMonthWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is in the same year as another date.
 
 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same year as aDate.
 */
- (BOOL) isSameYearAsDate: (NSDate *) aDate;

/**
 Test to see if current date is in the same year as another date with a calendar.

 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date is in the same year as aDate.
 */
- (BOOL) isSameYearAsDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of this year.
 
 @return        YES or NO based on if current date is in this year.
 */
- (BOOL) isThisYear;

/**
 Test to see if current date part of this year with a calendar.

 @return        YES or NO based on if current date is in this year.
 */
- (BOOL) isThisYearWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of next year.
 
 @return        YES or NO based on if current date is in next year.
 */
- (BOOL) isNextYear;

/**
 Test to see if current date part of next year with a calendar.

 @return        YES or NO based on if current date is in next year.
 */
- (BOOL) isNextYearWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date part of last year.
 
 @return        YES or NO based on if current date is last year.
 */
- (BOOL) isLastYear;

/**
 Test to see if current date part of last year with a calendar.

 @return        YES or NO based on if current date is last year.
 */
- (BOOL) isLastYearWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is before another date.
 
 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date comes before aDate
 */
- (BOOL) isEarlierThanDate: (NSDate *) aDate;

/**
 Test to see if current date is after another date.
 
 @param aDate   Date used to test current date against.
 @return        YES or NO based on if current date comes after aDate
 */
- (BOOL) isLaterThanDate: (NSDate *) aDate;

/**
 Test to see if current date is a typical work workday.
 
 @return        YES or NO based on if current date is a typical work workday.
 */
- (BOOL) isTypicallyWorkday;

/**
 Test to see if current date is a typical work workday with a calendar.

 @return        YES or NO based on if current date is a typical work workday.
 */
- (BOOL) isTypicallyWorkdayWithCalendar:(NSCalendar *)calendar;

/**
 Test to see if current date is a typical weekend.
 
 @return        YES or NO based on if current date is a typical weekend.
 */
- (BOOL) isTypicallyWeekend;

/**
 Test to see if current date is a typical weekend with a calendar.

 @return        YES or NO based on if current date is a typical weekend.
 */
- (BOOL) isTypicallyWeekendWithCalendar:(NSCalendar *)calendar;

/**
 Creates a new date by adding dates to current date.
 
 @param dDays   Number of days to add.
 @return        New date with additional days
 */
- (NSDate *) dateByAddingDays: (NSInteger) dDays;

/**
 Creates a new date by subtracting dates to current date.
 
 @param dDays   Number of days to add.
 @return        New date minus days
 */
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;

/**
 Creates a new date by adding hours to current date.
 
 @param dHours  Number of hours to add.
 @return        New date with additional hours
 */
- (NSDate *) dateByAddingHours: (NSInteger) dHours;

/**
 Creates a new date by subtracting hours to current date.
 
 @param dHours  Number of hours to add.
 @return        New date minus hours.
 */
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;

/**
 Creates a new date by adding minutes to current date.
 
 @param dMinutes    Number of minutes to add.
 @return            New date with additional days
 */
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;

/**
 Subtracts the number of minutes from the current date.
 
 @param dMinutes  Number of minutes to subtract from current date.
 @return          New date minus minutes.
 */
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

/**
 Creates a date for the start of the current day.

 @return          New date.
 */
- (NSDate *) dateAtStartOfDay;

/**
 Creates a date for the start of the current day with a calendar.

 @return          New date.
 */
- (NSDate *) dateAtStartOfDayWithCalendar:(NSCalendar *)calendar;

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate;

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate withCalendar:(NSCalendar *)calendar;

/**
 Creates a date object from a string with provided date format.
 
 @param string  String representation of date.
 
 @param format  Date format used against string date.
 
 @return date   Date object created from string.
 **/
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 Creates a date object from a string with provided date format with a timezone.

 @param string  String representation of date.

 @param format  Date format used against string date.

 @return date   Date object created from string.
 **/
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone;

/**
 Creates a date from a month day and year.
 
 @param month   Number for month.
 
 @param day     Number for day.
 
 @param year    Number for year.
 
 @return Date object created from provided month, day, and year.
 **/
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;

/**
 Creates a date from a month day and year with a calendar.

 @param month   Number for month.

 @param day     Number for day.

 @param year    Number for year.
 
 @param calendar    Calendar to use for date.

 @return Date object created from provided month, day, and year.
 **/
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year withCalendar:(NSCalendar *)calendar;

/**
 Creates a date from a month, day, year and calendar type.
 
 @param month       Number for month.
 
 @param day         Number for day.
 
 @param year        Number for year.
 
 @param calendar    Calendar to use for date.
 
 @return Date object created from provided month, day, year and calendar.
 **/
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year calendarIdentifier:(NSString *)calendarIdentifier;

/**
 Creates a natural language date from current date to another date.
 
 @param date Date to get span from.
 
 @return String representation of date span.
 */
- (NSString *)humanDateSinceDate:(NSDate *)date;

/**
 Creates a natural language date from current date to now.
 
 @return String representation of date span.
 */
- (NSString *)humanDateSinceNow;

/**
 Creates a natural language date from to date to another date.
 
 @param date Date to get span from.
 
 @param toDate Date to get span to.
 
 @return String representation of date span.
 */
+ (NSString *)humanDateFromDate:(NSDate *)date toDate:(NSDate *)toDate;

/**
 Creates a date object from an RFC3339 specific string format.
 
 @param dateString String representation of RFC3339 date.
 */
+ (NSDate *)dateWithRFC3339String:(NSString *)dateString;

/**
 Creates a date object from an RFC3339 specific string format.
 
 @param dateString String representation of RFC3339 date.
 
 @param locale The local to use when formatting the date.
 */
+ (NSDate *)dateWithRFC3339String:(NSString *)dateString forLocal:(NSLocale *)locale;

@end

@interface NSDate (Annex_Deprecated)
+ (NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day year:(NSInteger)year calendar:(NSString *)calendar __deprecated_msg("Use +dateWithMonth:day:year:calendarIdentifier: instead.");
@end



