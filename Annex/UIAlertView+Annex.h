//
//  UIAlertView+Annex.h
//  Annex
//
//  Created by Wess Cope on 5/11/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

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
           completionHandler:(void(^)(BOOL didCancel, NSInteger buttonIndex))callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
