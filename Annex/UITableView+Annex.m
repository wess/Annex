//
//  UITableView+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/19/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UITableView+Annex.h"

@implementation UITableView (Annex)
- (void)update:(void(^)(__weak UITableView *this))handler
{
    [self beginUpdates];
    handler(self);
    [self endUpdates];
}
@end
