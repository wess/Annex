//
//  UIView+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIView+Annex.h"

@interface AnnexProxyView : UIView
@property (copy, nonatomic) void(^drawBlock)(CGRect);
@end

@implementation AnnexProxyView

- (void)drawRect:(CGRect)rect
{
    if(self.drawBlock)
        self.drawBlock(rect);
}

@end

@implementation UIView (Annex)
@dynamic gradientBackgroundColors;

#pragma mark - Getters -
- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)top
{
    return self.y;
}

- (CGFloat)left
{
    return self.x;
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

#ifdef QUARTZCORE_H

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

#endif

#pragma mark - Setters -
- (void)setOrigin:(CGPoint)_origin
{
    CGRect frame    = self.frame;
    frame.origin    = _origin;
    self.frame      = frame;
}


- (void)setSize:(CGSize)_size
{
    CGRect frame    = self.frame;
    frame.size      = _size;
    self.frame      = frame;
}

- (void)setY:(CGFloat)_y
{
    CGRect frame    = self.frame;
    frame.origin.y  = _y;
    self.frame      = frame;
}

- (void)setTop:(CGFloat)y
{
    [self setY:y];
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)x
{
    [self setX:x];
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame        = self.frame;
    frame.size.width    = width;
    self.frame          = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame        = self.frame;
    frame.size.height   = height;
    self.frame          = frame;
}

#ifdef QUARTZCORE_H
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setGradientBackgroundColors:(NSArray *)gradientColors
{
    NSMutableArray *withColor = [NSMutableArray array];
    [gradientColors enumerateObjectsUsingBlock:^(UIColor *obj, NSUInteger idx, BOOL *stop) {
        [withColor addObject:(id)(obj).CGColor];
    }];
    
    CAGradientLayer *gradientLayer  = [[CAGradientLayer alloc] init];
    gradientLayer.colors            = [NSArray arrayWithArray:withColor];
    gradientLayer.frame             = self.bounds;
    
    [self.layer addSublayer:gradientLayer];
}

- (UIImage *)rasterizedToImage
{
    UIGraphicsBeginImageContext(self.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *rasterizedView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rasterizedView;
}
#endif

+ (UIView *)viewWithFrame:(CGRect)rect drawRect:(void(^)(CGRect rect))block
{
    AnnexProxyView *view = [[AnnexProxyView alloc] initWithFrame:rect];
    view.drawBlock = [block copy];
    
    return view;
}

+ (UIView *)viewFromNib:(UINib *)nib withOwner:(id)owner options:(NSDictionary *)options
{
    return [[nib instantiateWithOwner:owner options:options] objectAtIndex:0];
}

+ (UIView *)viewFromNib:(UINib *)nib withOwner:(id)owner
{
    return [UIView viewFromNib:nib withOwner:owner];
}

+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner bundle:(NSBundle *)bundle options:(NSDictionary *)options
{
    return [UIView viewFromNib:[UINib nibWithNibName:nibName bundle:bundle] withOwner:owner options:options];
}

+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner bundle:(NSBundle *)bundle
{
    return [UIView viewFromNibWithName:nibName withOwner:owner bundle:bundle options:nil];
}

+ (UIView *)viewFromNibWithName:(NSString *)nibName withOwner:(id)owner
{
    return [UIView viewFromNibWithName:nibName withOwner:owner bundle:nil];
}



@end
