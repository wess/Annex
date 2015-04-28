//
//  UIButton+Annex.h
//  Annex
//
//  Created by Wess Cope on 3/7/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnnexActionHandler)(id sender);

@interface UIButton (Annex)
/**
 `UIButton(Annex)` is an extension to UIButton with additional functionality.
 */

/**
 Background colors for different button states.
 */
@property (strong, nonatomic) NSMutableDictionary *backgroundColors;

/**
 Placeholder image to used when image hasn't been loaded yet.
 */
@property (strong, nonatomic) UIImage *placeholderImage;

/**
 Sets the button background color for specific control states.
 
 @param backgroundColor Color for the background
 @param state           Control state that indicates when background color is used.
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 Adds a block based action to a UIButton.
 
 @param handler Block called when button is tapped.
 */
- (void)addActionHandler:(AnnexActionHandler)handler;

@end
