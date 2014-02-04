//
//  UIView+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, AnnexSnapshotBlurType) {
	AnnexSnapshotBlurTypeLightEffect,
	AnnexSnapshotBlurTypeExtraLightEffect,
	AnnexSnapshotBlurTypeDarkEffect
};

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
- (UIImage *)snapshotImage;

#endif

/**
 Creates an image from the current view with AnnexSnapshotBlurType type.
 @param type AnnexSnapshotBlurType type.
 @return Image created from a view with blur.
 */
- (UIImage *)blurredSnapshotWithType:(AnnexSnapshotBlurType)type;

/**
 Creates an image from the current view.
 @param Color a UIColor to blur the snapshot image with.
 @return Image created from a view.
 */
- (UIImage *)blurredSnapshotWithTintColor:(UIColor *)color;

/**
 Creates a new view with a block based drawRect.
 
 @param rect    frame for the view.
 @param block   drawing code to be executed when the view is presented (or `drawn`).
 @return        new view with drawing from the drawRect block.
 */
+ (UIView *)viewWithFrame:(CGRect)rect drawRect:(void(^)(CGRect rect))block;

/**
 Convience method for loading a UIView from a nib file.
 
 @param nib     Nib object loaded from view's nib file.
 @param owner   Loaded view's owner
 @param options Options for when loading the nib file.
 @return        UIView based object loaded from a nib.
 */
+ (UIView *)viewFromNib:(UINib *)nib withOwner:(id)owner options:(NSDictionary *)options;

/**
 Convience method for loading a UIView from a nib file.
 
 @param nib     Nib object loaded from view's nib file.
 @param owner   Loaded view's owner
 @return        UIView based object loaded from a nib.
 */
+ (UIView *)viewFromNib:(UINib *)nib withOwner:(id)owner;

/**
 Convience method for loading a UIView from a nib file.
 
 @param nibName     Name of nib file to load view from.
 @param owner       Loaded view's owner
 @param bundle      Bundle that conains nib file.
 @param options     Options for when loading the nib file.
 @return            UIView based object loaded from a nib.
 */
+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner bundle:(NSBundle *)bundle options:(NSDictionary *)options;

/**
 Convience method for loading a UIView from a nib file.
 
 @param nibName     Name of nib file to load view from.
 @param owner       Loaded view's owner
 @param bundle      Bundle that conains nib file.
 @return            UIView based object loaded from a nib.
 */
+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner bundle:(NSBundle *)bundle;

/**
 Convience method for loading a UIView from a nib file.
 
 @param nibName     Name of nib file to load view from.
 @param owner       Loaded view's owner
 @return            UIView based object loaded from a nib.
 */
+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner;


@end

@interface UIView (AnnexDeprecatedMethods)

/**
 Creates an image from the current view.
 @return Image created from a view.
 */
- (UIImage *)rasterizedToImage __deprecated_msg("Use -snapshotImage instead.");

@end


