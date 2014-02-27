//
//  UIImageView+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnnexImageViewCompletionBlock)(UIImage *image, NSError *error);

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

/**
 Loads image for image view asyncronously from a URL and scale.
 
 @param NSURL URL of image.
 @param CGSize the size of the image you want scaled in post processing
 */
- (void)setImageForURL:(NSURL *)url scaledToSize:(CGSize)size;

/**
 Returns image for image view asyncronously from a URL with completion block for post processing.
 This method does not set the image automatically. Must be performed in the completion block.
 
 @param NSURL URL of image.
 @param AnnexImageViewCompletionBlock completion block
 */
- (void)setImageForURL:(NSURL *)url completion:(AnnexImageViewCompletionBlock)completion;

/**
 Returns image for image view asyncronously from a URL with completion block for post processing.
 This method does not set the image automatically. Must be performed in the completion block.
 
 @param NSURL URL of image.
 @param CGSize size to scale the image to return in the completion block
 @param AnnexImageViewCompletionBlock completion block
 */
- (void)setImageForURL:(NSURL *)url scaledToSize:(CGSize)size completion:(AnnexImageViewCompletionBlock)completion;
@end
