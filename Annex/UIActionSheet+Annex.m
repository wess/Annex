//
//  UIActionSheet+Annex.m
//  Annex
//
//  Created by Juan Alvarez on 2/13/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UIActionSheet+Annex.h"

#import <objc/runtime.h>

@implementation UIActionSheet (Annex)

static NSString *const AnnexActionSheetBlockKey = @"AnnexActionSheetBlock";

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    if (destructiveButtonTitle) {
        self.destructiveButtonIndex = [self addButtonWithTitle:destructiveButtonTitle];
    }
    
    va_list args;
    va_start(args, otherButtonTitles);
    
    for (NSString *title = otherButtonTitles; title != nil; title = (__bridge NSString *)va_arg(args, void *)) {
        [self addButtonWithTitle:title];
    }
    
    va_end(args);
    
    if (cancelButtonTitle) {
        self.cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
    }
    
    return self;
}

#pragma mark -
#pragma mark Action Sheet Show Methods

- (void)showInView:(UIView *)view completion:(AnnexActionSheetBlock)completionBlock
{
    [self saveCompletionHandler:completionBlock];
    
    [self showInView:view];
}

- (void)showFromToolbar:(UIToolbar *)view completion:(AnnexActionSheetBlock)completionBlock
{
    [self saveCompletionHandler:completionBlock];
    
    [self showFromToolbar:view];
}

- (void)showFromTabBar:(UITabBar *)view completion:(AnnexActionSheetBlock)completionBlock
{
    [self saveCompletionHandler:completionBlock];
    
    [self showFromTabBar:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated completion:(AnnexActionSheetBlock)completionBlock
{
    [self saveCompletionHandler:completionBlock];
    
    [self showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated completion:(AnnexActionSheetBlock)completionBlock
{
    [self saveCompletionHandler:completionBlock];
    
    [self showFromRect:rect inView:view animated:animated];
}

#pragma mark -
#pragma mark Private Methods

- (void)saveCompletionHandler:(AnnexActionSheetBlock)block
{
    if (block != NULL) {
        objc_setAssociatedObject(self, [AnnexActionSheetBlockKey UTF8String], block, OBJC_ASSOCIATION_COPY);
    }
}

- (void)removeCompletionHandler
{
    AnnexActionSheetBlock callback = objc_getAssociatedObject(self, [AnnexActionSheetBlockKey UTF8String]);
    
    if (callback != NULL) {
        objc_setAssociatedObject(self, [AnnexActionSheetBlockKey UTF8String], nil, OBJC_ASSOCIATION_COPY);
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL didCancel = (buttonIndex == self.cancelButtonIndex);
    
    AnnexActionSheetBlock callback = objc_getAssociatedObject(self, [AnnexActionSheetBlockKey UTF8String]);
    
    if (callback != NULL) {
        callback(self, didCancel, buttonIndex);
        
        [self removeCompletionHandler];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    AnnexActionSheetBlock callback = objc_getAssociatedObject(self, [AnnexActionSheetBlockKey UTF8String]);
    
    if (callback != NULL) {
        callback(self, YES, self.cancelButtonIndex);
        
        [self removeCompletionHandler];
    }
}

@end
