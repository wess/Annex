//
//  UIColor+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Annex)
/**
 `UIColor(Annex)` is an extension to UIColor with additional functionality.
 
 Note: Parts borrowed from Erica Sadun's UIColor-Expanded (https://www.github.com/erica/uicolor-utilities)
 */


/**
 Property to get current color space model
 */
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;

/**
 Property to indicate if the color is using a monochrome colorspace
 */
@property (nonatomic, readonly) BOOL usesMonochromeColorspace;

/**
 Property to indicate if the color is using a RGB colorspace
 */
@property (nonatomic, readonly) BOOL usesRGBColorspace;

/**
 Property that indicates if the current color instance can provide RGB defined components.
 */
@property (nonatomic, readonly) BOOL canProvideRGBComponents;

/**
 Property to access the red color space of a UIColor
 */
@property (nonatomic, readonly) CGFloat red;

/**
 Property to access the green color space of a UIColor
 */
@property (nonatomic, readonly) CGFloat green;

/**
 Property to access the blue color space of a UIColor
 */
@property (nonatomic, readonly) CGFloat blue;

/**
 Property to access the white color space of a UIColor
 */
@property (nonatomic, readonly) CGFloat white;

/**
 Property to access the alpha channel of a UIColor
 */
@property (nonatomic, readonly) CGFloat alpha;


/**
 Creates a color from a CSS style hex string.
 
 @param hexString   CSS Style hex string
 @return            Color created from CSS style hex string.
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

/**
 Generates a random color
 
 @return Random color.
 */
+ (UIColor *)randomColor;

/**
 Takes current color and changes it's alpha to create a new color
 
 @param alpha   Value used to change the color's alpha channel.
 @return        Color created from current color with new alpha value.
 */
- (UIColor *)colorByChangingAlphaTo:(CGFloat)alpha;

@end
