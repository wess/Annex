//
//  UIView+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#ifdef  QUARTZCORE_H
/**
 Options for rounding corners on UIViews.
 */
typedef NS_ENUM(NSInteger, AnnexViewRoundedCornerMask)
{
    AnnexViewRoundedCornerNone         = 0,
    AnnexViewRoundedCornerTopLeft      = 1 << 0,
    AnnexViewRoundedCornerTopRight     = 1 << 1,
    AnnexViewRoundedCornerBottomLeft   = 1 << 2,
    AnnexViewRoundedCornerBottomRight  = 1 << 3,
    AnnexViewRoundedCornerAll          = (1 << 4) - 1
};
#endif

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

/**
 Creates a layer mask for rounding individual corners of a UIView.
 
 @param AnnexViewRoundedCornerMask      Specify which corner/s are to be rounded.
 @param float                           The radius of the rounded corner/s.
 */
- (void)setRoundedCorners:(AnnexViewRoundedCornerMask)corners withRadius:(CGFloat)radius;

/**
 Removes from a superview using an animation.
 
 @param UIViewAnimationTransition   Specify which animation transition/s to use.
 @param NSTimeInterval              How long the animation should take.
 */
- (void)removeFromSuperviewWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

/**
 Adds a subview using an animation.
 
 @param UIViewAnimationTransition   Specify which animation transition/s to use.
 @param NSTimeInterval              How long the animation should take.
 */
- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;


#endif

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





