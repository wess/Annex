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
    
    [self setImageForURL:url completion:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"UIButton image loading failed: %@", error.debugDescription);
        }
        
        __block UIImage *imageResult = image;
        
        if (image) {
            if (CGSizeEqualToSize(size, CGSizeZero)) {
                imageResult = image;
            } else {
                NSString *kScaledImageKey = [url.absoluteString stringByAppendingFormat:@"_size_%f_%f", size.width, size.height];
                
                if ([AnnexImageCache imageForKey:kScaledImageKey]) {
                    imageResult = [AnnexImageCache imageForKey:kScaledImageKey];
                } else {
                    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
                    
                    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
                    
                    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                    
                    UIGraphicsEndImageContext();
                    
                    imageResult = newImage;
                    
                    if (imageResult) {
                        [AnnexImageCache setImage:imageResult forKey:kScaledImageKey];
                    }
                }
            }
        }
        
        if (imageResult) {
            weakSelf.image = imageResult;
        }
    }];
}

- (void)setImageForURL:(NSURL *)url completion:(AnnexImageViewCompletionBlock)completion
{
    if([AnnexImageCache imageForKey:url.absoluteString])
    {
        if (completion != NULL) {
            [NSObject executeBlockOnMainThread:^{
                completion([AnnexImageCache imageForKey:url.absoluteString], nil);
            }];
        }
    }
    else
    {
        [AnnexImageCache imageFromURL:url completionHandler:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"UIButton image loading failed: %@", error.debugDescription);
            }
            
            if (image) {
                [AnnexImageCache setImage:image forKey:url.absoluteString];
            }
            
            if (completion != NULL) {
                [NSObject executeBlockOnMainThread:^{
                    completion(image, error);
                }];
            }
        }];
    }
}

@end
