//
//  NSArray+Annex.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSArray+Annex.h"

@implementation NSArray (Annex)

- (id)combineWithObject:(id)obj block:(id (^)(id, id))block
{
    id result = obj;
    for(id value in self)
        result = block(result, value);
    return result;
}

- (NSArray *)mapObjectsWithBlock:(id (^)(id object))block
{
    return [[self combineWithObject:[NSMutableArray arrayWithCapacity:[self count]] block:^(NSMutableArray *acc, id value) {
        [acc addObject:block(value)];
    }] copy];
}

- (instancetype)withoutNulls
{
    NSArray* temp = [self arrayByRemovingObjectsOfClass:[NSNull class]];
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:[temp count]];
    for(id obj in temp)
    {
        if([obj respondsToSelector:@selector(withoutNulls)])
            [result addObject:[obj withoutNulls]];
        else
            [result addObject:obj];
    }

    return [result copy];
}

- (instancetype)arrayByRemovingObjectsOfClass:(Class)aClass
{
    NSMutableArray* results = [NSMutableArray array];

    for(id o in self)
    {
        if([o isKindOfClass:aClass] == NO)
            [results addObject:o];
    }

    return [results copy];
}

- (id)objectAtIndex:(NSUInteger)index ifKindOf:(Class)kind
{
    return [self objectAtIndex:index ifKindOf:kind defaultValue:nil];
}

- (id)objectAtIndex:(NSUInteger)index ifKindOf:(Class)kind defaultValue:(id)defaultValue
{
    id obj = self[index];
    return [obj isKindOfClass:kind] ? obj : defaultValue;
}

#pragma mark - Type specific helpers

- (NSArray*)arrayAtIndex:(NSUInteger)index
{
    return [self arrayAtIndex:index defaultValue:@[]];
}

- (NSArray*)arrayAtIndex:(NSUInteger)index defaultValue:(NSArray*)defaultValue
{
    return [self objectAtIndex:index ifKindOf:[NSArray class] defaultValue:defaultValue];
}

- (NSDictionary*)dictionaryAtIndex:(NSUInteger)index
{
    return [self dictionaryAtIndex:index defaultValue:@{}];
}

- (NSDictionary*)dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary*)defaultValue
{
    return [self objectAtIndex:index ifKindOf:[NSDictionary class] defaultValue:defaultValue];
}

- (NSString*)stringAtIndex:(NSUInteger)index
{
    return [self stringAtIndex:index defaultValue:@""];
}

- (NSString*)stringAtIndex:(NSUInteger)index defaultValue:(NSString*)defaultValue
{
    return [self objectAtIndex:index ifKindOf:[NSString class] defaultValue:defaultValue];
}

- (NSNumber*)numberAtIndex:(NSUInteger)index
{
    return [self numberAtIndex:index defaultValue:nil];
}

- (NSNumber*)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber*)defaultValue
{
    return [self objectAtIndex:index ifKindOf:[NSNumber class] defaultValue:defaultValue];
}

- (BOOL)boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue
{
    NSNumber* defVal = @(defaultValue);
    return [[self objectAtIndex:index ifKindOf:[NSNumber class] defaultValue:defVal] boolValue];
}

- (NSDate*)dateAtIndex:(NSUInteger)index
{
    return [self dateAtIndex:index defaultValue:nil];
}

- (NSDate*)dateAtIndex:(NSUInteger)index defaultValue:(NSDate*)defaultValue
{
    return [self objectAtIndex:index ifKindOf:[NSDate class] defaultValue:defaultValue];
}

@end
