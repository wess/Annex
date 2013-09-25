//
//  UIAlertView+Annex.m
//  Annex
//
//  Created by Wess Cope on 5/11/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIAlertView+Annex.h"
#import <objc/runtime.h>

@implementation UIAlertView (Annex)
static NSString *const AnnexAlertViewBlock = @"AnnexAlertViewBlock";

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            completionHandler:(void(^)(BOOL didCancel, NSInteger buttonIndex))callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if(self)
    {

        objc_setAssociatedObject(self, [AnnexAlertViewBlock UTF8String], callback, OBJC_ASSOCIATION_COPY);
        
        va_list args;
        va_start(args, otherButtonTitles);
        for(NSString *title = otherButtonTitles; title != nil; title = (__bridge NSString *)va_arg(args, void *))
            [self addButtonWithTitle:title];
        
        va_end(args);
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    BOOL didCancel                      = (buttonIndex == self.cancelButtonIndex);
    void(^callback)(BOOL, NSInteger)    = objc_getAssociatedObject(self, [AnnexAlertViewBlock UTF8String]);

    callback(didCancel, buttonIndex);
    
    objc_removeAssociatedObjects(callback);
}

@end
