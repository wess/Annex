//
//  UIView+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Annex)
/**
 `UIView(Annex)` is an extension to UIView with additional functionality.
 */

/**
 Shortcut for working with a view's origin.
 */
@property (nonatomic)           CGPoint   origin;

/**
 Shortcut for working with a view's size.
 */
@property (nonatomic)           CGSize    size;

/**
 Shortcut for working with a view's Y offset.
 */
@property (nonatomic)           CGFloat   y;

/**
 Shortcut for working with a view's top offset.
 @see y
 */
@property (nonatomic)           CGFloat   top;

/**
 Shortcut for working with a view's x offset.
 */
@property (nonatomic)           CGFloat   x;

/**
 Shortcut for working with a view's left offset.
 @see x
 */
@property (nonatomic)           CGFloat   left;

/**
 Shortcut for working with a view's right offset.
 */
@property (nonatomic)           CGFloat   right;

/**
 Shortcut for working with a view's bottom offset.
 */
@property (nonatomic)           CGFloat   bottom;

/**
 Short cut for working with a view's width.
 */
@property (nonatomic)           CGFloat   width;

/**
 Shortcut for working witha view's height.
 */
@property (nonatomic)           CGFloat   height;

#ifdef QUARTZCORE_H
/**
 Sets the corner radius of the view
 */
@property (nonatomic)           CGFloat   cornerRadius;

/**
 Sets the width of a view's border.
 */
@property (nonatomic)           CGFloat   borderWidth;

/**
 Sets the color of a view's border.
 */
@property (nonatomic, strong)   UIColor   *borderColor;

/**
 Sets a view's background color to a vertical gradient.
 @discuss the color at the 0 index is the top, 1 index is bottom.
 */
@property (assign, nonatomic)   NSArray   *gradientBackgroundColors;

/**
 Creates an image from the current view.
 @return Image created from a view.
 */
- (UIImage *)rasterizedToImage;

#endif

/**
 Creates a new view with a block based drawRect.
 
 @param rect    frame for the view.
 @param block   drawing code to be executed when the view is presented (or `drawn`).
 @return        new view with drawing from the drawRect block.
 */
+ (UIView *)viewWithFrame:(CGRect)rect drawRect:(void(^)(CGRect rect))block;

@end
