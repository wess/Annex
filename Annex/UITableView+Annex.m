//
//  UITableView+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/19/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UITableView+Annex.h"
#import <objc/runtime.h>

@implementation UITableView (Annex)
- (void)update:(void(^)(__weak UITableView *this))handler
{
    [self beginUpdates];
    handler(self);
    [self endUpdates];
}

- (id)stubbingCellForIdentifier:(NSString *)identifier
{
    NSParameterAssert(identifier);
    
    NSMutableDictionary *identifiers = objc_getAssociatedObject(self, _cmd);
    if(identifiers == nil)
    {
        identifiers = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self, _cmd, identifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *cell = [identifiers objectForKey:identifier];
    if(!cell)
    {
        cell                    = [self dequeueReusableCellWithIdentifier:identifier];
        identifiers[identifier] = cell;
    }
    
    return cell;
}

- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier layout:(void(^)(id cell))handler
{
    NSParameterAssert(handler);
    
    UITableViewCell *cell = [self stubbingCellForIdentifier:identifier];
    cell.contentView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.rowHeight);
    
    [cell prepareForReuse];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(self.frame)];
    
    [cell.contentView addConstraint:constraint];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    [cell.contentView removeConstraint:constraint];
    
    if(self.separatorStyle != UITableViewCellSeparatorStyleNone)
        size.height += 1 / [UIScreen mainScreen].scale;
    
    
    return size.height;
}

@end
