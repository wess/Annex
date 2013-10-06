//
//  NSDictionary+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSDictionary+Annex.h"

@implementation NSDictionary (Annex)
@dynamic jsonString;
@dynamic jsonData;
@dynamic httpQueryString;

- (NSString *)jsonString
{
    NSString *jsonString = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSData *)jsonData
{
    NSError *error      = nil;
    NSData *jsonData    = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    NSAssert(error == nil, @"toJSONData Error: %@", error.description);
    
    return jsonData;
}

- (NSString *)httpQueryString
{
    NSMutableArray *query = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [query addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    
    return [query componentsJoinedByString:@"&"];
}

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString
{
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONWritingPrettyPrinted error:&error];
    NSAssert(error == nil, @"DictionaryFromJSONString Error: %@", error.description);
    
    return result;    
}

- (id)combineWithObject:(id)obj block:(id (^)(id, id<NSCopying>, id))block
{
    id result = obj;
    for(id<NSCopying> key in [self allKeys])
        result = block(result, key, self[key]);
    return result;
}

- (NSDictionary*)mapObjectsAndKeysWithBlock:(id (^)(id<NSCopying> key, id object))block
{
    return [[self combineWithObject:[NSMutableDictionary dictionary]  block:^(NSMutableDictionary* acc, id<NSCopying> key, id obj) {
        acc[key] = block(key, obj);
        return acc;
    }] copy];
}

- (NSDictionary *)withoutNulls
{
    NSMutableDictionary* replaced = [NSMutableDictionary dictionaryWithDictionary:self];
    NSString* blank = @"";

    for(NSString* key in self)
    {
        id object = [self objectForKey:key];
        if([object isKindOfClass:[NSNull class]] == YES)
            [replaced setObject:blank forKey:key];
        else if([object isKindOfClass:[NSDictionary class]] == YES)
            [replaced setObject:[(NSDictionary*)object withoutNulls] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary: replaced];
}

- (id)objectForKey:(id)key ifKindOf:(Class)kind
{
    return [self objectForKey:key ifKindOf:kind defaultValue:nil];
}

- (id)objectForKey:(id)key ifKindOf:(Class)kind defaultValue:(id)defaultValue
{
    id obj = self[key];
    return [obj isKindOfClass:kind] ? obj : defaultValue;
}

#pragma mark - Type specific helpers

- (NSArray*)arrayForKey:(id)key
{
    return [self arrayForKey:key defaultValue:@[]];
}

- (NSArray*)arrayForKey:(id)key defaultValue:(NSArray*)defaultValue
{
    return [self objectForKey:key ifKindOf:[NSArray class] defaultValue:defaultValue];
}

- (NSDictionary*)dictionaryForKey:(id)key
{
    return [self dictionaryForKey:key defaultValue:@{}];
}

- (NSDictionary*)dictionaryForKey:(id)key defaultValue:(NSDictionary*)defaultValue
{
    return [self objectForKey:key ifKindOf:[NSDictionary class] defaultValue:defaultValue];
}

- (NSString*)stringForKey:(id)key
{
    return [self stringForKey:key defaultValue:@""];
}

- (NSString*)stringForKey:(id)key defaultValue:(NSString*)defaultValue
{
    return [self objectForKey:key ifKindOf:[NSString class] defaultValue:defaultValue];
}

- (NSNumber*)numberForKey:(id)key
{
    return [self numberForKey:key defaultValue:nil];
}

- (NSNumber*)numberForKey:(id)key defaultValue:(NSNumber*)defaultValue
{
    return [self objectForKey:key ifKindOf:[NSNumber class] defaultValue:defaultValue];
}

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    NSNumber* defVal = @(defaultValue);
    return [[self objectForKey:key ifKindOf:[NSNumber class] defaultValue:defVal] boolValue];
}

- (NSDate*)dateForKey:(id)key
{
    return [self dateForKey:key defaultValue:nil];
}

- (NSDate*)dateForKey:(id)key defaultValue:(NSDate*)defaultValue
{
    return [self objectForKey:key ifKindOf:[NSDate class] defaultValue:defaultValue];
}

@end
