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
@end
