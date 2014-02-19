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
static NSString *const AnnexAlertViewBlockKey				= @"AnnexAlertViewBlock";
static NSString *const AnnexAlertViewWithContextBlockKey	= @"AnnexAlertViewWithContextBlock";

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
			completionHandler:(AnnexAlertViewBlock)callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if(self)
    {
		if (callback != NULL)
			objc_setAssociatedObject(self, [AnnexAlertViewBlockKey UTF8String], callback, OBJC_ASSOCIATION_COPY);
        
        va_list args;
        va_start(args, otherButtonTitles);
        for(NSString *title = otherButtonTitles; title != nil; title = (__bridge NSString *)va_arg(args, void *))
            [self addButtonWithTitle:title];
        
        va_end(args);
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
 completionWithContextHandler:(AnnexAlertViewWithContextBlock)callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if(self)
    {
		if (callback != NULL)
			objc_setAssociatedObject(self, [AnnexAlertViewWithContextBlockKey UTF8String], callback, OBJC_ASSOCIATION_COPY);
        
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
    BOOL didCancel										= (buttonIndex == self.cancelButtonIndex);
	
    AnnexAlertViewBlock callback						= objc_getAssociatedObject(self, [AnnexAlertViewBlockKey UTF8String]);
	AnnexAlertViewWithContextBlock callbackWithContext	= objc_getAssociatedObject(self, [AnnexAlertViewWithContextBlockKey UTF8String]);

	if (callback != NULL) {
		callback(didCancel, buttonIndex);
		
        objc_setAssociatedObject(self, [AnnexAlertViewBlockKey UTF8String], nil, OBJC_ASSOCIATION_COPY);
	}
	
	else if (callbackWithContext != NULL) {
		callbackWithContext(alertView, didCancel, buttonIndex);
		
		objc_setAssociatedObject(self, [AnnexAlertViewWithContextBlockKey UTF8String], nil, OBJC_ASSOCIATION_COPY);
	}
}

@end
