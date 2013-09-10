//
//  NSArray+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Annex)
/**
 `NSArray(Annex)` is an extension to NSArray with additional functionality.
 */

/**
 Maps objects in an array using a block and returns array of newly mapped objects.
 
 @param Block Called with every object inside the array and returns objject.
 @return Array Created from self with objects processed with mapping block.
 */
- (NSArray *)mapObjectsWithBlock:(id(^)(id object))block;
@end
