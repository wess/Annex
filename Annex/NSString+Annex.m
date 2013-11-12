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

typedef struct
{
    __unsafe_unretained NSString *string;
    NSUInteger length;

} NSStringPatternResult;

static void throwStringError(NSError *error)
{
    NSException *exception = [NSException exceptionWithName:@"NSString format with pattern error" reason:error.debugDescription userInfo:nil];
    @throw exception;
}

static NSStringPatternResult adaptInitialPattern(NSString *string, NSUInteger subtract)
{
    NSError *error                  = nil;
    NSRegularExpression *pattern    = [NSRegularExpression regularExpressionWithPattern:@"\\{((\\d+)?(?:,(\\d+)?)?)\\}" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result    = [pattern firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, string.length)];
    NSRange range                   = [result rangeAtIndex:3];
    
    if(range.location == NSNotFound)
        range = [result rangeAtIndex:2];
    
    NSInteger repeats = [[string substringWithRange:range] integerValue];
    if(repeats > 0)
        string = [string stringByReplacingCharactersInRange:[result rangeAtIndex:1] withString:[NSString stringWithFormat:@"1,%d", (repeats - subtract)]];
    else
        repeats = INFINITY;
    
    return ((NSStringPatternResult){.string = string, .length = repeats});
}

static NSString *stepPattern(NSMutableString **pattern, long step)
{
    NSError *error              = nil;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\(([^)(]*)(?<!\\\\)\\)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    if(error)
    {
        throwStringError(error);
        return @"";
    }
    
    NSTextCheckingResult *matches = [regex firstMatchInString:*pattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, (*pattern).length)];
    
    if(!matches || matches.range.location == NSNotFound)
        return nil;
    
    NSString *result        = [*pattern substringWithRange:[matches rangeAtIndex:1]];
    NSString *indexString   = [NSString stringWithFormat:@"$%ld", step];
    
    [*pattern replaceCharactersInRange:matches.range withString:indexString];
    
    return result;
}

static NSString *validCharactersInString(NSString *string, NSRegularExpression *pattern)
{
    if(!string || !pattern)
        return nil;
    
    NSError *error                      = nil;
    NSMutableString *patternString      = [pattern.pattern mutableCopy];
    NSString *firstPattern              = stepPattern(&patternString, 1);
    NSMutableString *validCharacters    = [[NSMutableString alloc] init];
    
    for(NSInteger i = 2; firstPattern != nil; i++)
    {
        NSUInteger step = 0;
        NSStringPatternResult patternResult;
        NSTextCheckingResult *result;
        
        do {
            
            patternResult   = adaptInitialPattern(firstPattern, i);

            if(patternResult.length == 0)
                break;
            
            firstPattern = patternResult.string;
            
            NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:patternResult.string options:NSRegularExpressionCaseInsensitive error:&error];

            if(error)
            {
                throwStringError(error);
                break;
            }

            result = [pattern firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, string.length)];

            if(!result)
                break;
            
            NSString *match = [string substringWithRange:result.range];
            string          = [string stringByReplacingCharactersInRange:result.range withString:@""];
            
            [validCharacters appendString:match];
            
            step += result.range.length;
            
        } while(result.range.length != patternResult.length);
        
        firstPattern = stepPattern(&patternString, (long)i);
    }
    
    return validCharacters;
}

//- (NSString *)patternStep:(NSMutableString **)pattern onString:(NSString *)string iterCount:(long)i resultFetcher:(NSMutableString **)mutableResult range:(NSRange)range placeholder:(NSString *)placeholder
static NSString *stepStringWithPattern(NSMutableString **pattern, NSString *string, long count, NSString **result, NSRange range, NSString *placeholder)
{
    NSString *firstPattern = stepPattern(pattern, count);
    
    if(!firstPattern)
        return @"";
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:firstPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if(error)
    {
        throwStringError(error);
        return @"";
    }
    
    NSTextCheckingResult *matchResult = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    long num = 0;
    
    if(!matchResult || matchResult.range.location == NSNotFound)
    {
        NSRegularExpression *numRepetEx = [NSRegularExpression regularExpressionWithPattern:@"\\{(\\d+)?(?:,(\\d+)?)?\\}" options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *numRep    = [numRepetEx firstMatchInString:firstPattern options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, firstPattern.length)];
        NSRange numRange                = [numRep rangeAtIndex:2];
        
        if (numRange.location == NSNotFound)
            numRange = [numRep rangeAtIndex:1];
        
        num = [firstPattern substringWithRange:numRange].integerValue;
        
        // Replaces the expected repetition on the group pattern with "+".
        firstPattern    = [firstPattern stringByReplacingCharactersInRange:numRep.range withString:@"+"];
        regex           = [NSRegularExpression regularExpressionWithPattern:firstPattern options:NSRegularExpressionCaseInsensitive error:&error];
        matchResult     = [regex firstMatchInString:string options:NSMatchingWithoutAnchoringBounds range:range];
    }
    
    NSString *stringMatched = [string substringWithRange:matchResult.range];
    *result = [*result stringByAppendingString:stringMatched];

    if(num > 0 && placeholder)
    {
        NSString *placeholderRepeat = [@"" stringByPaddingToLength:(num - stringMatched.length) withString:placeholder startingAtIndex:0];
        *result                     = [*result stringByAppendingString:placeholderRepeat];
        firstPattern                = [NSString stringWithFormat:@"[%@%@]{%ld}", firstPattern, placeholder, num];
    }
    
    if(matchResult)
    {
        range.location  = matchResult.range.location + matchResult.range.length;
        range.length    = string.length - range.location;
    }
    
    return [NSString stringWithFormat:@"(%@)%@", firstPattern, stepStringWithPattern(pattern, string, ++count, result, range, placeholder)];
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
    
    NSString *validCharacters           = validCharactersInString(self, expression);
    NSMutableString *pattern            = [expression.pattern mutableCopy];
    NSMutableString *formattedString    = [[NSMutableString alloc] init];
    NSString *newPattern                = stepStringWithPattern(&pattern, validCharacters, 1, &formattedString, NSMakeRange(0, validCharacters.length), placeholder);
    
    [formattedString replaceOccurrencesOfString:newPattern withString:pattern options:NSRegularExpressionSearch range:NSMakeRange(0, formattedString.length)];
    
    return [formattedString copy];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern
{
    return [self formatStringWithPattern:pattern placeholder:nil];
}

- (NSString *)formatStringWithPattern:(NSString *)pattern placeholder:(NSString *)placeholder
{
    NSError *error              = nil;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    throwStringError(error);
    
    
    return [self formatStringWithRegex:regex placeholder:placeholder];
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
