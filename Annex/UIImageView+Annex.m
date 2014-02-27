//
//  UIImageView+Annex.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIImageView+Annex.h"
#import "AnnexImageCache.h"
#import "NSObject+Annex.h"
#import "UIImage+Annex.h"
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
    if (self.placeholderImage)
        self.image = self.placeholderImage;
    
    __weak typeof(self) weakSelf = self;
    
    [self setImageForURL:url completion:^(UIImage *image, NSError *error) {
        if (image) {
            weakSelf.image = image;
        }
    }];
}

- (void)setImageForURL:(NSURL *)url withPlaceholderImage:(UIImage *)image
{
    self.placeholderImage = image;
    [self setImageForURL:url];
}

- (void)setImageForURL:(NSURL *)url scaledToSize:(CGSize)size
{
    if (self.placeholderImage)
        self.image = self.placeholderImage;
    
    __weak typeof(self) weakSelf = self;
    
    [self setImageForURL:url scaledToSize:size completion:^(UIImage *image, NSError *error) {
        if (image) {
            weakSelf.image = image;
        }
    }];
}

- (void)setImageForURL:(NSURL *)url completion:(AnnexImageViewCompletionBlock)completion
{
    [self setImageForURL:url scaledToSize:CGSizeZero completion:completion];
}

- (void)setImageForURL:(NSURL *)url scaledToSize:(CGSize)size completion:(AnnexImageViewCompletionBlock)completion
{
    if (url == nil) {
        if (completion != NULL) {
            [NSObject executeBlockOnMainThread:^{
                completion(nil, nil);
            }];
        }
        
        return;
    }
    
    NSString *kImageKey;
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        kImageKey = url.absoluteString;
    } else {
        kImageKey = [url.absoluteString stringByAppendingFormat:@"_size_%f_%f", size.width, size.height];
    }
    
    if ([AnnexImageCache imageForKey:kImageKey]) {
        if (completion != NULL) {
            [NSObject executeBlockOnMainThread:^{
                completion([AnnexImageCache imageForKey:kImageKey], nil);
            }];
        }
    } else {
        [AnnexImageCache imageFromURL:url completionHandler:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"UIButton image loading failed: %@", error.debugDescription);
            }
            
            __block UIImage *imageResult = image;
            
            if (imageResult) {
                if (CGSizeEqualToSize(size, CGSizeZero)) {
                    [AnnexImageCache setImage:imageResult forKey:kImageKey];
                } else {
                    imageResult = [image imageScaledToSize:size];
                    
                    if (imageResult) {
                        [AnnexImageCache setImage:imageResult forKey:kImageKey];
                    }
                }
            }
            
            if (completion != NULL) {
                [NSObject executeBlockOnMainThread:^{
                    completion(imageResult, error);
                }];
            }
        }];
    }
}

@end
