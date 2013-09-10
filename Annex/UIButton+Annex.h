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
 Asyncronously sets the image for a Button from a URL/Image path.
 
 @param NSURL           URL of image to load.
 @param UIControlState  State of button that will display image.
 */
- (void)setImageForURL:(NSURL *)url forState:(UIControlState)state;

@end
