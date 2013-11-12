//
//  NSString+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSString+Annex.h"
#import <CommonCrypto/CommonCrypto.h>
#import "Annex.h"

@implementation NSString (Annex)

typedef struct
{
    __unsafe_unretained NSString *result;
    NSUInteger length;

} PatternResult;


static NSString *validCharactersForString(NSString *string, NSRegularExpression *regex)
{
    if (string == nil || !regex)
        return nil;
    
    NSMutableString *pattern = [NSMutableString stringWithString:regex.pattern];
    
    NSError *error = nil;
    
    NSString *firstGroupPattern         = getStepPattern(&pattern, 1);
    NSMutableString *validCharacters    = [NSMutableString new];
    
    for (int i = 2; firstGroupPattern != nil; i++)
    {
        NSUInteger n = 0;
        
        PatternResult adaptingResult;
        NSTextCheckingResult *result;
        
        do
        {
            adaptingResult = adaptsFirstGroupPattern(firstGroupPattern, n);

            if (adaptingResult.length == 0)
                break;
            
            firstGroupPattern = adaptingResult.result;
            
            // Try to match the pattern
            NSRegularExpression *patternRegex = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            if (error) NSLog(@"%@", error);
            
            result = [patternRegex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, string.length)];

            if (! result)
                break;
            
            NSString *matchedString = [string substringWithRange:result.range];
            
            string = [string stringByReplacingCharactersInRange:result.range withString:@""];
            
            [validCharacters appendString:matchedString];
            
            n += result.range.length;
        }
        while (result.range.length != adaptingResult.length);
        
        firstGroupPattern = getStepPattern(&pattern, i);
    }
    
    return validCharacters;
}

static PatternResult adaptsFirstGroupPattern(NSString *group,  NSUInteger subtractBy)
{
    NSError *error = nil;
    
    // Gets the expected maximum repetition for the current group
    NSRegularExpression *maxRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{((\\d+)?(?:,(\\d+)?)?)\\}" options:0 error:&error];
    NSTextCheckingResult *numRep = [maxRepetEx firstMatchInString:group options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, group.length)];
    
    // Tries to get the maximum
    NSRange range = [numRep rangeAtIndex:3];
    if (range.location == NSNotFound)
    {
        // Goes for the minimum
        range = [numRep rangeAtIndex:2];
    }
    
    NSInteger numberOfRepetitions = [group substringWithRange:range].integerValue;
    
    // Replaces the the content of braces with {1, numberOfRepetitions}
    if (numberOfRepetitions > 0)
        group = [group stringByReplacingCharactersInRange:[numRep rangeAtIndex:1] withString:[NSString stringWithFormat:@"1,%d", numberOfRepetitions - subtractBy]];
    else
        numberOfRepetitions = INFINITY;
    
    PatternResult result = (PatternResult){.result = group, .length = numberOfRepetitions};
    
    result.result = group;
    result.length = numberOfRepetitions;
    
    return result;
}

// Recursive method to format the given string based on the given pattern and placeholder, returning the new regex pattern to be used on NSMutableString's replaceOccurrencesOfString:withString:options:range: and editing the pattern to match this method's replacement string.
static NSString *patternStepOnString(NSMutableString **pattern, NSString *string, long i, NSMutableString **mutableResult, NSRange range, NSString *placeholder)
{
    NSString *firstGroupPattern = getStepPattern(pattern, i);
    
    if (! firstGroupPattern)
        return @"";
    
    NSError *error                  = nil;
    NSRegularExpression *regex      = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:0 error:&error];
    NSTextCheckingResult *result    = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];

    long num = 0;
    
    if ((! result || result.range.location == NSNotFound))
    {
        NSRegularExpression *numRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{(\\d+)?(?:,(\\d+)?)?\\}" options:0 error:&error];
        NSTextCheckingResult *numRep    = [numRepetEx firstMatchInString:firstGroupPattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, firstGroupPattern.length)];
        NSRange numRange                = [numRep rangeAtIndex:2];
        
        if (numRange.location == NSNotFound)
            numRange = [numRep rangeAtIndex:1];
        
        num = [firstGroupPattern substringWithRange:numRange].integerValue;
        
        firstGroupPattern = [firstGroupPattern stringByReplacingCharactersInRange:numRep.range withString:@"+"];
        
        regex   = [NSRegularExpression regularExpressionWithPattern:firstGroupPattern options:0 error:&error];
        result  = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    }
    
    NSString *stringMatched = [string substringWithRange:result.range];
    
    [*mutableResult appendString:stringMatched];
    
    if (num > 0 && placeholder)
    {
        NSString *placeholderRepetition = [@"" stringByPaddingToLength:num-stringMatched.length withString:placeholder startingAtIndex:0];
        [*mutableResult appendString:placeholderRepetition];

        firstGroupPattern = [NSString stringWithFormat:@"[%@%@]{%ld}", firstGroupPattern, placeholder, num];
    }
    
    if (result)
    {
        range.location = result.range.location + result.range.length;
        range.length    = string.length - range.location;
    }
    
    return [NSString stringWithFormat:@"(%@)%@", firstGroupPattern, patternStepOnString(pattern, string, ++i, mutableResult, range, placeholder)];
}

static NSString *getStepPattern(NSMutableString **pattern, long i)
{
    NSError *error                          = nil;
    NSRegularExpression *regex              = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\(([^)(]*)(?<!\\\\)\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *checkingResult    = [regex firstMatchInString:*pattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, (*pattern).length)];
    
    if (! checkingResult || checkingResult.range.location == NSNotFound)
        return nil;
    
    NSString *result = [*pattern substringWithRange:[checkingResult rangeAtIndex:1]];

    [*pattern replaceCharactersInRange:checkingResult.range withString:[NSString stringWithFormat:@"$%ld", i]];
    
    return result;
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

- (NSString *)formatStringWithRegex:(NSRegularExpression *)expression
{
    return [self formatStringWithRegex:expression placeholder:nil];
}

- (NSString *)formatStringWithRegex:(NSRegularExpression *)expression placeholder:(NSString *)placeholder
{
    
    placeholder = placeholder?: @"";
    
    NSString *validCharacters           = validCharactersForString(self, expression);
    NSMutableString *pattern            = [NSMutableString stringWithString:expression.pattern];
    NSMutableString *formattedString    = [[NSMutableString alloc] init];
    NSString *newPattern                = patternStepOnString(&pattern, validCharacters, 1, &formattedString, NSMakeRange(0, validCharacters.length), placeholder);

    
    [formattedString replaceOccurrencesOfString:newPattern withString:pattern options:NSRegularExpressionSearch range:NSMakeRange(0, formattedString.length)];
    
    return [formattedString copy];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern
{
    return [self formatStringWithPattern:pattern placeholder:nil];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    return @"";
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

@end
