//
//  NSString+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSString+Annex.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Annex)

- (NSString *)md5
{
    return [NSString md5HashWithString:self];
}

- (NSString *)sha1
{
    return [NSString sha1HashWithString:self];
}

- (NSString *)URLEncoded
{
    return [NSString urlEncodedStringWithString:self];
}

+ (NSString *)md5HashWithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
	unsigned char digest[16];
	CC_MD5( cStr, strlen(cStr), digest);
    
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
    
	return  output;
}

+ (NSString *)sha1HashWithString:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data 	 = [NSData dataWithBytes:cstr length:string.length];
    
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
	CC_SHA1(data.bytes, data.length, digest);
    
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
    
	return output;
}

+ (NSString *)urlEncodedStringWithString:(NSString *)string
{
    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL,(CFStringRef)@":/=,!$&'()*+;[]@#?",  kCFStringEncodingUTF8);
    NSString *returnString = (__bridge NSString *)strRef;
    CFRelease(strRef);
    
    return returnString;
}

+ (NSString *)uuid
{
    CFUUIDRef puuid         = CFUUIDCreate( nil );
    CFStringRef uuidString  = CFUUIDCreateString( nil, puuid );
    NSString *result        = (__bridge NSString *)CFStringCreateCopy( NULL, uuidString);

    CFRelease(puuid);
    CFRelease(uuidString);

    return result;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

@end
