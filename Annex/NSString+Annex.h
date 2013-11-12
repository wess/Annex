//
//  NSString+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Annex)
/**
 `NSString(Annex)` is an extension to NSString with additional functionality.
 */

/**
 Creates an MD5 Hash from the current string.
 
 @return MD5 Hash created from current string.
 */
- (NSString *)md5;

/**
 Creates an SHA1 Hash from the current string.
 
 @return SHA1 Hash created from current string.
 */
- (NSString *)sha1;

/**
 Encodes string for safe use with URLs
 
 @return String that has been URL encoded.
 */
- (NSString *)URLEncoded;

/**
 Strips HTML from string.
 
 @return String with no HTML tags
 */
- (NSString *)stringByRemovingHTML;

/**
 */
- (NSString *)formatStringWithRegex:(NSRegularExpression *)expression;

/**
 */
- (NSString *)formatStringWithRegex:(NSRegularExpression *)expression placeholder:(NSString *)placeholder;

/**
 */
- (NSString *)formatStringWithPattern:(NSString *)pattern;

/**
 */
- (NSString *)formatStringWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder;


/**
 Creates an MD5 Hash from a given string.
 
 @param string  The string to create MD5 hash from.
 @return        MD5 Hash created from current string.
 */
+ (NSString *)md5HashWithString:(NSString *)string;

/**
 Creates an SHA1 Hash from a given string.
 
 @param string  The string to create SHA1 hash from.
 @return        SHA1 Hash created from current string.
 */
+ (NSString *)sha1HashWithString:(NSString *)string;

/**
 Encodes the given string to be URL safe/friendly.
 
 @param string  The string to URL encode.
 @return        URL encoded string.
 */
+ (NSString *)urlEncodedStringWithString:(NSString *)string;

/**
 Retreives a system universal id.
 
 @return    String created by the system.
 */
+ (NSString *)uuid;

/**
 Converts an NSDate to a string with a given format.
 
 @param date    The date to convert to a string
 @param format  The format to convert the date to.
 @return            String created from date using format.
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;

/**
 Converts an NSDate to a string with a given format.
 
 @param date        The date to convert to a string
 @param format      The format to convert the date to.
 @param timeZone    Timezone used when converting date to string.
 @return            String created from date using format.
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone;



@end
