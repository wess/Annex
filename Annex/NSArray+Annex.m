//
//  NSArray+Annex.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSArray+Annex.h"

@implementation NSArray (Annex)
- (NSArray *)mapObjectsWithBlock:(id(^)(id object))block
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj)];
    }];
    
    return [result copy];
}
@end
