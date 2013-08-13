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
    rect.size   = image.size;
    
    [color set];
    UIRectFill(rect);
    
    [image drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *filledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return filledImage;

}

@end
