//
//  NSNumberFormatter+Annex.h
//  Annex
//
//  Created by Wess Cope on 3/25/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (Annex)
+ (NSNumberFormatter *)currencyFormatter;
+ (NSNumberFormatter *)currencyFormatterWithLocale:(NSLocale *)locale;
+ (NSNumberFormatter *)percentFormatter;
+ (NSNumberFormatter *)percentFormatterWithLocale:(NSLocale *)locale;
+ (NSNumberFormatter *)formatterWithLocale:(NSLocale *)locale;
+ (NSNumberFormatter *)formatter;
@end
