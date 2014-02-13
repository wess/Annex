//
//  UIActionSheet+Annex.h
//  Annex
//
//  Created by Juan Alvarez on 2/13/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIActionSheet.h>

typedef void(^AnnexActionSheetBlock)(UIActionSheet *actionSheet, BOOL didCancel, NSInteger buttonIndex);

@interface UIActionSheet (Annex) <UIActionSheetDelegate>

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showInView:(UIView *)view completion:(AnnexActionSheetBlock)completionBlock;

@end
