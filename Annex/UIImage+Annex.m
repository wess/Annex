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
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
