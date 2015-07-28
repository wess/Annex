//
//  UITableView+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/19/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Annex)
/**
 `UITableview(Annex)` is an extension to UITableCiew with additional functionality.
 */

/**
 Simple addition to support block based updates for tableviews.
 
 @param handler Block to contain table view minipulation methods.
 */
- (void)update:(void(^)(__weak UITableView *this))handler;

/**
 Addition for better handling of dynamic cell heights for content and layouts.
 
 @param identifier  Identifier used for cell in cache.
 @param handler     Required method for adding content to cell, as you would in cellForRowAtIndexPath;
 @return            Height for the cell.
 
 */
- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier layout:(void(^)(id cell))handler;
@end
