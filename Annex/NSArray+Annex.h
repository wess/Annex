//
//  NSArray+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Annex)
- (NSArray *)mapObjectsWithBlock:(id(^)(id object))block;
@end
