//
//  UIActionSheet+Annex.h
//  Annex
//
//  Created by Juan Alvarez on 2/13/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIActionSheet.h>

typedef void(^AnnexActionSheetBlock)(UIActionSheet *actionSheet, BOOL didCancel, NSInteger buttonIndex);

@interface UIActionSheet(Annex) <UIActionSheetDelegate>
/**
 `UIActionSheet(Annex)` is helper category for UIActionSheet.
 */

/**
 Creates a basic block based UIActionSheet
 
 @param NSString        Title of action view.
 @param NSString        Title of cancel button.
 @param NSString        Title of destructive button.
 @param NSString, ...   Titles for other buttons.
 @return                Instance of UIActionSheet.
 */

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Present the action sheet with block based handler for handling selection.
 
 @param UIView                  View to show action sheet in.
 @param AnnexActionSheetBlock   Block called when action sheet option is selected.
 */
- (void)showInView:(UIView *)view completion:(AnnexActionSheetBlock)completionBlock;

@end
