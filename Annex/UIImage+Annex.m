//
//  UIImage+Annex.m
//  Annex
//
//  Created by Wess Cope on 8/13/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIImage+Annex.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Annex)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

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

+ (UIImage *)GifImageWithDate:(NSData *)data
{
    static int(^delayCentisecondsForImageAtIndex)(CGImageSourceRef source, size_t i) = ^int(CGImageSourceRef source, size_t i)
    {
        int delayCentiseconds = 1;
        CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        if(properties) {
            CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
            if(gifProperties) {
                NSNumber *number = (NSNumber *)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
                if (number == NULL || [number doubleValue] == 0) {
                    number = (NSNumber *)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
                }
                if ([number doubleValue] > 0) {
                    // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                    delayCentiseconds = (int)lrint([number doubleValue] * 100);
                }
            }
            CFRelease(properties);
        }
        return delayCentiseconds;
    };
    
    static int (^pairGCD)(int a, int b) = ^int(int a, int b) {
        if (a < b)
            return pairGCD(b, a);
        while (true) {
            int const r = a % b;
            if (r == 0)
                return b;
            a = b;
            b = r;
        }
    };
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    
    if(!source)
        return nil;
    
    size_t count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    
    for(size_t i = 0; i < count; ++i)
    {
        images[i]               = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentiseconds[i]    = delayCentisecondsForImageAtIndex(source, i);
    }
    
    int totalDurationCentiseconds = 0;
    
    for(size_t i = 0; i < count; ++i)
        totalDurationCentiseconds += delayCentiseconds[i];
    
    int gcd = delayCentiseconds[0];
    for(size_t i = 1; i < count; ++i)
        gcd = pairGCD(delayCentiseconds[i], gcd);
    
    size_t frameCount = totalDurationCentiseconds / gcd;
    
    UIImage *frames[frameCount];
    for(size_t i = 0, f = 0; i < count; ++i)
    {
        UIImage *frame = [UIImage imageWithCGImage:images[i]];
        
        for(size_t j = delayCentiseconds[i] / gcd; j > 0; --j)
            frames[f++] = frame;
    }
    
    UIImage *animation = [UIImage animatedImageWithImages:[NSArray arrayWithObjects:frames count:frameCount] duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    
    for(int i = 0; i < count; ++i)
        CGImageRelease(images[i]);
    
    CFRelease(source);
    
    return animation;

}

- (void)applyFilter:(CIFilter *)filter completion:(void(^)(UIImage *image))handler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIContext *context  = [CIContext contextWithOptions:nil];
        CIImage *output     = filter.outputImage;
        CGImageRef imageRef = [context createCGImage:output fromRect:[output extent]];
        UIImage *image      = [UIImage imageWithCGImage:imageRef];
        
        CGImageRelease(imageRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
           if(handler)
               handler([image copy]);
        });
    });
}

+ (void)applyFilter:(CIFilter *)filter toImage:(UIImage *)image completion:(void(^)(UIImage *image))handler
{
    [image applyFilter:filter completion:handler];
}


@end
