//
//  NSNumberFormatter+Annex.m
//  Annex
//
//  Created by Wess Cope on 3/25/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "NSNumberFormatter+Annex.h"

@implementation NSNumberFormatter (Annex)
+ (NSNumberFormatter *)currencyFormatter
{
    NSNumberFormatter *formatter    = [NSNumberFormatter formatter];
    formatter.numberStyle           = NSNumberFormatterCurrencyStyle;
    
    return formatter;
}

+ (NSNumberFormatter *)currencyFormatterWithLocale:(NSLocale *)locale
{
    NSNumberFormatter *formatter    = [NSNumberFormatter formatterWithLocale:locale];
    formatter.numberStyle           = NSNumberFormatterCurrencyStyle;
    
    return formatter;
}

+ (NSNumberFormatter *)percentFormatter
{
    NSNumberFormatter *formatter    = [NSNumberFormatter formatter];
    formatter.numberStyle           = NSNumberFormatterPercentStyle;
    formatter.minimumFractionDigits = 2;
    
    return formatter;
}

+ (NSNumberFormatter *)percentFormatterWithLocale:(NSLocale *)locale
{
    NSNumberFormatter *formatter    = [NSNumberFormatter formatterWithLocale:locale];
    formatter.numberStyle           = NSNumberFormatterPercentStyle;
    formatter.minimumFractionDigits = 2;
    
    return formatter;
}

+ (NSNumberFormatter *)formatterWithLocale:(NSLocale *)locale
{
    NSNumberFormatter *formatter    = [[NSNumberFormatter alloc] init];
    formatter.formatterBehavior     = NSNumberFormatterBehavior10_4;
    formatter.locale                = locale;
    
    return formatter;
}

+ (NSNumberFormatter *)formatter
{
    return [NSNumberFormatter formatterWithLocale:[NSLocale currentLocale]];
}

@end
