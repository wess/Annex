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

/**
 Returns a new image scaled proportionally to size.
 
 @param CGSize size to scale image to.
 
 @return UIImage image scaled to size.
 */
- (UIImage *)imageScaledToSize:(CGSize)size;

/**
 Returns a new image scaled proportionally to size. Can set if image is opaque or not
 
 @param CGSize size to scale image to.
 @param BOOL whether the image is opaque or not
 
 @return UIImage image scaled to size.
 */
- (UIImage *)imageScaledToSize:(CGSize)size opaque:(BOOL)opaque;

/**
 Returns a new image scaled to size. Can set if image is opaque and/or proportionally
 
 @param CGSize size to scale image to.
 @param BOOL whether the image is opaque or not.
 @param BOOL whether the image should be proportionally sized to set size.
 
 @return UIImage image scaled to size.
 */
- (UIImage *)imageScaledToSize:(CGSize)targetSize opaque:(BOOL)opaque proportionally:(BOOL)proportionally;
@end
