//
//  UIBezierPath+Annex.h
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, AnnexBezierPathArrowDirection) {
    AnnexBezierPathArrowDirectionNone   = 0,
    AnnexBezierPathArrowDirectionUp     = 1 << 0,
    AnnexBezierPathArrowDirectionRight  = 1 << 1,
    AnnexBezierPathArrowDirectionDown   = 1 << 2,
    AnnexBezierPathArrowDirectionLeft   = 1 << 3
};


@interface UIBezierPath (Annex)
/**
 Creates a BezierPath in the shap of an arrow in the provided direction.
 
 @param rect        Frame to draw arrow in.
 @param scale       Arrow scaling size.
 @param direction   Direction to draw the arrow in.
 @return            UIBezierPath for created arrow.
 */
+ (UIBezierPath *)pathForArrowSymbolInRect:(CGRect)rect scale:(CGFloat)scale direction:(AnnexBezierPathArrowDirection)direction;
@end
