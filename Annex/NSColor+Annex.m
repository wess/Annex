//
//  NSColor+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSColor+Annex.h"

@implementation NSColor (Annex)
@dynamic colorSpaceModel;
@dynamic canProvideRGBComponents;
@dynamic red;
@dynamic green;
@dynamic blue;
@dynamic white;
@dynamic alpha;


- (CGColorSpaceModel)colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents
{
    switch(self.colorSpaceModel)
    {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        
        default:
            return NO;
    }
    
    return NO;
}

- (BOOL) usesMonochromeColorspace
{
    return (self.colorSpaceModel == kCGColorSpaceModelMonochrome);
}

- (BOOL) usesRGBColorspace
{
    return (self.colorSpaceModel == kCGColorSpaceModelRGB);
}

- (CGFloat) red
{
	NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    CGFloat r = 0.0f;
    
    switch (self.colorSpaceModel)
    {
        case kCGColorSpaceModelRGB:
            [self getRed:&r green:NULL blue:NULL alpha:NULL];
            break;
        case kCGColorSpaceModelMonochrome:
            [self getWhite:&r alpha:NULL];
        default:
            break;
    }
    
    return r;
}

- (CGFloat) green
{
	NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    CGFloat g = 0.0f;
    
    switch (self.colorSpaceModel)
    {
        case kCGColorSpaceModelRGB:
            [self getRed:NULL green:&g blue:NULL alpha:NULL];
            break;
        case kCGColorSpaceModelMonochrome:
            [self getWhite:&g alpha:NULL];
        default:
            break;
    }
    
    return g;
}

- (CGFloat) blue
{
	NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    CGFloat b = 0.0f;
    
    switch (self.colorSpaceModel)
    {
        case kCGColorSpaceModelRGB:
            [self getRed:NULL green:NULL blue:&b alpha:NULL];
            break; 
        case kCGColorSpaceModelMonochrome:
            [self getWhite:&b alpha:NULL];
        default:
            break;
    }
    
    return b;
}

- (CGFloat) alpha
{
    CGFloat a;
    [self getWhite:NULL alpha:&a];
    return a;
}

- (CGFloat) white
{
	NSAssert(self.usesMonochromeColorspace, @"Must be a Monochrome color to use -white");
    
    CGFloat w;
    [self getWhite:&w alpha:NULL];
    return w;
}

+ (NSColor *)colorFromHexString:(NSString *)hexString
{
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if(hexString.length == 3)
    {
        const char *temp = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
        const unsigned short t[] = {temp[0], temp[0], temp[1], temp[1], temp[2], temp[2]};
        hexString = [NSString stringWithCharacters:t length:6];
    }
    
	NSColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	if (nil != hexString)
	{
		NSScanner *scanner = [NSScanner scannerWithString:hexString];
		(void) [scanner scanHexInt:&colorCode];	// ignore error
	}
    
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	
    result      = [NSColor colorWithDeviceRed:(float)redByte / 0xff
                                        green:(float)greenByte / 0xff
                                         blue:(float)blueByte / 0xff
                                        alpha:1.0f];
	return result;
}

+ (NSColor *)randomColor
{
    return [NSColor colorWithDeviceRed:((float)random()/(float)RAND_MAX)
                                 green:((float)random()/(float)RAND_MAX)
                                  blue:((float)random()/(float)RAND_MAX)
                                 alpha:1.0f];
    
}

@end
