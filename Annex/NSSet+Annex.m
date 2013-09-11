//
//  NSSet+Annex.m
//  Annex
//
//  Created by Jeremy Tregunna on 8/2/2013.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import "NSSet+Annex.h"

@implementation NSSet (Annex)

- (NSSet*)filteredSetUsingBlock:(BOOL (^)(id obj, BOOL* stop))block
{
    NSMutableSet* result = [NSMutableSet set];
    if(block != nil)
    {
        for(id obj in self)
        {
            BOOL stop = NO;
            if(block(obj, &stop) && !stop)
                [result addObject:obj];

            if(stop)
                break;
        }
    }
    return [result copy];
}

@end

@implementation NSMutableSet (Annex)

- (NSSet*)filteredSetUsingBlock:(BOOL (^)(id obj, BOOL* stop))block
{
    return [[super filteredSetUsingBlock:block] mutableCopy];
}

@end
