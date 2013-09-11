//
//  NSSet+Annex.h
//  Annex
//
//  Created by Jeremy Tregunna on 8/2/2013.
//  Copyright (c) 2013 Jeremy Tregunna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (Annex)

/**
 Creates a new set selecting only the items that pass the test provided
 by block.

 @param block The test used to filter items
 @return Set A set which is a subset of the receiver.
 */
- (NSSet*)filteredSetUsingBlock:(BOOL (^)(id, BOOL*))block;

@end
