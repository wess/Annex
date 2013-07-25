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
 Placeholder image to used when image hasn't been loaded yet.
 */
@property (strong, nonatomic) UIImage *placeholderImage;

/**
 
 */
- (void)setImageForURL:(NSURL *)url;

/**
 
 */
- (void)setImageForURL:(NSURL *)url withPlaceholderImage:(UIImage *)image;

@end
