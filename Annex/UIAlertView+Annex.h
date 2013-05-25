//
//  UIAlertView+Annex.h
//  Annex
//
//  Created by Wess Cope on 5/11/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Annex)
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                   onComplete:(void(^)(BOOL didCancel, NSInteger buttonIndex))callback
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
