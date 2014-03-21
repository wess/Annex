//
//  UIImage+Annex.m
//  Annex
//
//  Created by Wess Cope on 8/13/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIImage+Annex.h"

@implementation UIImage (Annex)
+ (UIImage *)fillImage:(UIImage *)image withColor:(UIColor *)color
{
    return [image fillImageWithColor:color];
}

- (UIImage *)fillImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGRect rect = CGRectZero;
    rect.size   = self.size;
    
    [color set];
    UIRectFill(rect);
    
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *filledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return filledImage;

}

- (UIImage *)imageScaledToSize:(CGSize)size
{
    return [self imageScaledToSize:size opaque:NO];
}

- (UIImage *)imageScaledToSize:(CGSize)size opaque:(BOOL)opaque
{
    return [self imageScaledToSize:size opaque:opaque proportionally:YES];
}

- (UIImage *)imageScaledToSize:(CGSize)targetSize opaque:(BOOL)opaque proportionally:(BOOL)proportionally
{
    CGFloat scaledWidth = targetSize.width;
    CGFloat scaledHeight = targetSize.height;
    
    CGPoint thumbnailPoint = CGPointZero;
    
    if (proportionally) {
        // get the proportional target size
        CGSize imageSize = self.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        
        CGFloat targetWidth = targetSize.width;
        CGFloat targetHeight = targetSize.height;
        
        CGFloat scaleFactor = 0.0;
        
        if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
            CGFloat widthFactor = targetWidth/width;
            CGFloat heightFactor = targetHeight/height;
            
            if (widthFactor < heightFactor) {
                scaleFactor = widthFactor;
            } else {
                scaleFactor = heightFactor;
            }
            
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            
            if (widthFactor < heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if (widthFactor > heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    CGSize scaledSize = CGSizeMake(scaledWidth, scaledHeight);
    
    CGRect imageFrame = CGRectZero;
    imageFrame.origin = thumbnailPoint;
    imageFrame.size = scaledSize;
    
    UIGraphicsBeginImageContextWithOptions(scaledSize, opaque, 0.0);
    
    [self drawInRect:imageFrame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
