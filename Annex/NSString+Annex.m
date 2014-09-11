//
//  NSString+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSString+Annex.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSArray+Annex.h"

NSString *AnnexStringCreditCardFormat       = @"#### #### #### ####";
NSString *AnnexStringUSPhoneNumberFormat    = @"(###) ###-####";

@implementation NSString (Annex)

- (NSString *)camelCaseString
{
    NSMutableArray *parts           = [[self componentsSeparatedByString:@"_"] mutableCopy];
    __block NSMutableString *output = [[NSMutableString alloc] initWithString:[parts stringAtIndex:0]];
    
    [parts removeObjectAtIndex:0];
    [parts enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
        [output appendString:string.capitalizedString];
    }];
    
    return [output copy];
}

- (NSString *)underscoreString
{
    NSMutableString *output     = [[NSMutableString alloc] init];
    NSString *buffer            = nil;
    NSCharacterSet *uppercase   = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet *lowercase   = [NSCharacterSet lowercaseLetterCharacterSet];
    NSScanner *scanner          = [NSScanner scannerWithString:self];
    
    [scanner setCaseSensitive:YES];
    
    while(scanner.isAtEnd == NO)
    {
        if([scanner scanCharactersFromSet:uppercase intoString:&buffer])
            [output appendString:[buffer lowercaseString]];
        
        if([scanner scanCharactersFromSet:lowercase intoString:&buffer])
            [output appendString:buffer];
        
        if(!scanner.isAtEnd)
            [output appendString:@"_"];
    }
    
    return [output copy];
}

- (BOOL)isNotEqualToString:(NSString *)aString
{
	return ![self isEqualToString:aString];
}

- (BOOL)isEqualToStringCaseInsensitive:(NSString *)aString
{
	NSComparisonResult result = [self caseInsensitiveCompare:aString];
	
	return (result == NSOrderedSame);
}

- (BOOL)isEqualToStringDiacriticallyInsensitive:(NSString *)aString
{
	NSComparisonResult result = [self compare:aString options:NSDiacriticInsensitiveSearch];
	
	return (result == NSOrderedSame);
}

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

- (NSString*)stringByRemovingHTML
{
    
	NSString *html          = self;
    NSScanner *thescanner   = [NSScanner scannerWithString:html];
    NSString *text          = nil;
    
    while (![thescanner isAtEnd])
    {
		[thescanner scanUpToString:@"<" intoString:NULL];
		[thescanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
	return html;
}


+ (NSString *)md5HashWithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
	unsigned char digest[16];
	CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
    
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
    
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
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

+ (NSString *)UUIDString
{
	// since the iOS Deployment target is iOS 6.1 we don't have to check for version compatibility
	NSUUID *uuid = [NSUUID UUID];
	
    return uuid.UUIDString;
}

- (NSUUID *)UUIDRepresentation
{
	NSUUID *uuid = [[NSUUID alloc] initWithUUIDString: self];
	
	return uuid;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format withTimeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone   = timeZone;
    dateFormatter.dateFormat = format;

    return [dateFormatter stringFromDate:date];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    if(index > self.length-1)
        return nil;

    unichar character = [self characterAtIndex:index];
    return [NSString stringWithCharacters:&character length:1];
}

- (id)objectForKeyedSubscript:(id)key
{
    if([key isKindOfClass:[NSString class]])
    {
        NSError *error = nil;
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:key options:0 error:&error];

        if(error)
            return nil;
        
        NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];

        if(result)
            return [self substringWithRange:result.range];
    }
    else if([key isKindOfClass:[NSArray class]])
    {
        NSInteger loc = [key[0] intValue];
        NSInteger len = [key[1] intValue];
        return [self substringWithRange:NSMakeRange((loc > 0) ? loc:self.length - labs(loc), len)];
    }
    
    return nil;
}

# pragma mark - Masking
static NSString *defaultPatternCharacter    = @"#";
static NSString *defaultPlaceHolder         = @"";

+ (NSString *)formatString:(NSString *)string withPattern:(NSString *)pattern
{
    return [[self class] formatString:string withPattern:pattern patternCharacter:defaultPatternCharacter];
}

+ (NSString *)formatString:(NSString *)string withPattern:(NSString *)pattern patternCharacter:(NSString *)character
{
    return [[self class] formatString:string withPattern:pattern patternCharacter:character placeholder:defaultPlaceHolder];
}

+ (NSString *)formatString:(NSString *)string withPattern:(NSString *)pattern patternCharacter:(NSString *)character placeholder:(NSString *)placeholder
{
    if([pattern isEqualToString:AnnexStringCreditCardFormat] || [pattern isEqualToString:AnnexStringUSPhoneNumberFormat])
        pattern = [pattern stringByReplacingOccurrencesOfString:defaultPatternCharacter withString:character];
    
    NSMutableString *result     = [pattern mutableCopy];
    NSUInteger formattedIndex   = 0;
    
    for (NSUInteger index = 0; index < pattern.length; index++)
    {
        NSRange range               = NSMakeRange(index, 1);
        NSString *currentMaskChar   = [pattern substringWithRange:range];
        
        if([currentMaskChar isEqualToString:character] && formattedIndex < string.length)
        {
            NSString *replaceCharacter = [string substringWithRange:NSMakeRange(formattedIndex, 1)];
            [result replaceCharactersInRange:range withString:replaceCharacter];
            
            formattedIndex++;
        }
        
    }
    
    [result replaceOccurrencesOfString:character withString:placeholder options:0 range:NSMakeRange(0, result.length)];

    return [result copy];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern
{
    return [[self class] formatString:self withPattern:pattern];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern patternCharacter:(NSString *)character
{
    return [[self class] formatString:self withPattern:pattern patternCharacter:character];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern patternCharacter:(NSString *)character placeholder:(NSString *)placeholder
{
    return [[self class] formatString:self withPattern:pattern patternCharacter:character placeholder:placeholder];
}


@end

@implementation NSString (DeprecatedMethods)

+ (NSString *)uuid
{
    return [self UUIDString];
}

@end















