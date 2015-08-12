//
//  UIImage+Annex.h
//  Annex
//
//  Created by Wess Cope on 8/13/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>



@interface UIImage (Annex)
/**
 `UIImage(Annex)` is an extension to UIImage with additional functionality.
 */

/**
    Creates an image for a color.

    @param UIColor Color of the image.
    @param CGSize Size of image to create

    @return UIImage for color and size.
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

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
 Creates and returns an animated image object.
 
 @param NSData Data that represents the GIF
 
 @return UIImage created from GIF data.
 */
+ (UIImage *)GifImageWithDate:(NSData *)data;

/**
 Apply a CIFilter to an image asyncronously.
 
 @param filter Filter object to appy to current instance.
 @param handler Callback executed after filter has been applied to image
 */

- (void)applyFilter:(CIFilter *)filter completion:(void(^)(UIImage *image))handler;

/**
 Apply a CIFilter to an image asyncronously.
 
 @param filter Filter object to appy to image.
 @param image Image to apply filter to.
 @param handler Callback executed after filter has been applied to image
 */
+ (void)applyFilter:(CIFilter *)filter toImage:(UIImage *)image completion:(void(^)(UIImage *image))handler;

@end
