//
//  UIImageView+Annex.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIImageView+Annex.h"
#import "AnnexImageCache.h"
#import <objc/runtime.h>

@implementation UIImageView (Annex)
static char ANNEX_PLACEHOLDER_IMAGE;
@dynamic placeholderImage;

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    objc_setAssociatedObject(self, &ANNEX_PLACEHOLDER_IMAGE, placeholderImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)placeholderImage
{
    return (UIImage *)objc_getAssociatedObject(self, &ANNEX_PLACEHOLDER_IMAGE);
}

- (void)setImageForURL:(NSURL *)url
{
    if([AnnexImageCache imageForKey:url.absoluteString])
    {
        self.image = [AnnexImageCache imageForKey:url.absoluteString];
    }
    else
    {
        if(self.placeholderImage)
            self.image = self.placeholderImage;
        
        [AnnexImageCache imageFromURL:url completion:^(UIImage *image, NSError *error) {
            if(error)
            {
                NSLog(@"UIButton image loading failed: %@", error.debugDescription);
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = self.image;
                });
            }
        }];
    }
}

- (void)setImageForURL:(NSURL *)url withPlaceholderImage:(UIImage *)image
{
    self.placeholderImage = image;
    [self setImageForURL:url];
}

@end
