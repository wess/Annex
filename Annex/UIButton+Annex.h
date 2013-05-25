//
//  UIButton+Annex.h
//  Annex
//
//  Created by Wess Cope on 3/7/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Annex)
/**
 `UIView(Annex)` is an extension to UIView with additional functionality.
 */

/**
 Background colors for different button states.
 */
@property (strong, nonatomic) NSMutableDictionary *backgroundColors;

/**
 Sets the button background color for specific control states.
 
 @param backgroundColor Color for the background
 @param state           Control state that indicates when background color is used.
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
