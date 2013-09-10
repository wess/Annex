//
//  UIImage+Annex.h
//  Annex
//
//  Created by Wess Cope on 8/13/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Annex)
/**
 `UIImage(Annex)` is an extension to UIImage with additional functionality.
 */

/**
 Takes an image and fills it with a color.
 
 @param UIImage Image to change/fill.
 @param UIColor Color to change image to.
 
 @return UIImage created by filling provided image with a color.
 */
+ (UIImage *)fillImage:(UIImage *)image withColor:(UIColor *)color;

/**
 Returns a new image based on self that has been filled with a new color.
 
 @param UIColor Color to change image to.
 
 @return UIImage created by filling provided image with a color.
 */
- (UIImage *)fillImageWithColor:(UIColor *)color;
@end
