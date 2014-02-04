//
//  UIAlertView+Annex.h
//  Annex
//
//  Created by Wess Cope on 5/11/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnnexAlertViewBlock)(BOOL didCancel, NSInteger buttonIndex);
typedef void(^AnnexAlertViewWithContextBlock)(UIAlertView *alertView, BOOL didCancel, NSInteger buttonIndex);

@interface UIAlertView (Annex)
/**
 `UIAlertView(Annex)` is helper category for UIAlertView.
 */

/**
 Creates a basic block based UIAlertView
 
 @param NSString        Title of alert view.
 @param NSString        Message to display in alert view.
 @param Block           Call back used when a button in the alert view is clicked.
 @param NSString        Title of cancel button.
 @param NSString, ...   List of buttons to display in alert view.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
			completionHandler:(AnnexAlertViewBlock)callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Creates a block based UIAlertView which returns the alert view in the completion handler
 
 @param NSString        Title of alert view.
 @param NSString        Message to display in alert view.
 @param Block           Call back used when a button in the alert view is clicked.
 @param NSString        Title of cancel button.
 @param NSString, ...   List of buttons to display in alert view.
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
 completionWithContextHandler:(AnnexAlertViewWithContextBlock)callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
