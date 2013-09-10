//
//  UIImageView+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Annex)
/**
 `UIImageView(Annex)` is an extension to UIImageView with additional functionality.
 */

/**
 Placeholder image to used when image hasn't been loaded yet.
 */
@property (strong, nonatomic) UIImage *placeholderImage;

/**
 Loads image for image view asyncronously from a URL.
 
 @param NSURL URL of image.
 */
- (void)setImageForURL:(NSURL *)url;

/**
 Loads image for image view asyncronously from a URL, with a placeholder image.
 
 @param NSURL URL of image.
 @param UIImage Image to use as placeholder.
 */
- (void)setImageForURL:(NSURL *)url withPlaceholderImage:(UIImage *)image;

@end
