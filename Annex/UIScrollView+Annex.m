//
//  UIScrollView+Annex.m
//  Annex
//
//  Created by Wess Cope on 4/9/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UIScrollView+Annex.h"
#import <objc/runtime.h>
#import "UIView+Annex.h"

@interface UIScrollView(AnnexPrivate)
- (void)floatingHeaderViewWillBeReplaced;
- (void)floatingHeaderViewWasReplaced;
- (void)scrolledFromTop:(CGFloat)fromTop toTop:(CGFloat)toTop;
@end

@implementation UIScrollView (Annex)
static void *topHeaderViewKey;
static void *topheaderViewContext;

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == topheaderViewContext)
    {
        if([keyPath isEqualToString:@"contentOffset"])
        {
            CGFloat fromTop = [[change objectForKey:@"old"] CGPointValue].y;
            CGFloat toTop   = [[change objectForKey:@"new"] CGPointValue].y;
            
            [self scrolledFromTop:fromTop toTop:toTop];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Accessors
- (UIView *)floatingHeaderView
{
    return objc_getAssociatedObject(self, topHeaderViewKey);
}

- (void)setFloatingHeaderView:(UIView *)floatingHeaderView
{
    [self floatingHeaderViewWillBeReplaced];
    objc_setAssociatedObject(self, topHeaderViewKey, floatingHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self floatingHeaderViewWasReplaced];
}

#pragma mark - topHeader setup
- (void)floatingHeaderViewWillBeReplaced
{
    if(self.floatingHeaderView)
    {
        UIEdgeInsets contentInset   = self.contentInset;
        UIEdgeInsets scrollInset    = self.scrollIndicatorInsets;
        
        contentInset.top    -= self.floatingHeaderView.height;
        scrollInset.top     -= self.floatingHeaderView.height;
        
        self.contentInset           = contentInset;
        self.scrollIndicatorInsets  = scrollInset;
        
        [self.floatingHeaderView removeFromSuperview];
        
        @try
        {
            [self removeObserver:self forKeyPath:@"contentOffset"];
        }
        @catch (NSException *__unused exception) {}
    }
}

- (void)floatingHeaderViewWasReplaced
{
    if(self.floatingHeaderView)
    {
        [self addSubview:self.floatingHeaderView];
        [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:topheaderViewContext];
        
        UIEdgeInsets contentInset = self.contentInset;
        UIEdgeInsets scrollInset = self.scrollIndicatorInsets;
        
        contentInset.top += self.floatingHeaderView.height;
        scrollInset.top += self.floatingHeaderView.height;
        
        self.contentInset = contentInset;
        self.scrollIndicatorInsets = scrollInset;
        
        [self setContentOffset:CGPointMake(0.0, -(self.floatingHeaderView.height)) animated:NO];
    }
}

- (void)scrolledFromTop:(CGFloat)fromTop toTop:(CGFloat)toTop
{
    CGPoint velocity        = [self.panGestureRecognizer velocityInView:self];
    BOOL isQuick            = (abs(velocity.y) > 1000);
    BOOL isDisplayingHeader = (self.floatingHeaderView.top + self.floatingHeaderView.height) > toTop;
    BOOL allHeaderIsShowing = self.floatingHeaderView.top >= fromTop;
    CGRect frame            = self.floatingHeaderView.frame;
    
    if(isQuick && !isDisplayingHeader && (fromTop > toTop))
    {
        frame.origin.y = toTop - self.floatingHeaderView.height + (fromTop - toTop);
        
        if(frame.origin.y > toTop)
            frame.origin.y = toTop;
    }
    
    if(isDisplayingHeader && frame.origin.y > toTop)
        frame.origin.y = toTop;
    
    if(allHeaderIsShowing && toTop < -self.floatingHeaderView.height)
        frame.origin.y = toTop;
    
    self.floatingHeaderView.frame = frame;
}

@end
