//
//  UIBezierPath+Annex.m
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import "UIBezierPath+Annex.h"

@implementation UIBezierPath (Annex)
static CGPoint pointWithOffset(CGPoint origin, CGPoint offset)
{
    return CGPointMake((origin.x + offset.x), (origin.y + offset.y));
}

+ (UIBezierPath *)pathForArrowSymbolInRect:(CGRect)rect scale:(CGFloat)scale direction:(AnnexBezierPathArrowDirection)direction
{
    CGFloat height      = CGRectGetHeight(rect) * scale;
    CGFloat width       = CGRectGetWidth(rect)  * scale;
    CGFloat size        = height < width? height : width;
    CGFloat thick       = size / 3;
    CGFloat halfHeight  = height / 2;
    CGFloat halfWidth   = width  / 2;
    CGPoint offsetPoint = CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect)  - width)  / 2, CGRectGetMinY(rect) + (CGRectGetHeight(rect) - height) / 2);
    UIBezierPath * path = [self bezierPath];
    
    if (direction == AnnexBezierPathArrowDirectionLeft || direction == AnnexBezierPathArrowDirectionRight)
    {
        if (direction == AnnexBezierPathArrowDirectionLeft)
        {
            [path moveToPoint:pointWithOffset(CGPointMake(0.f, halfHeight), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width - thick, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(thick, halfHeight), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, height), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width - thick, height), offsetPoint)];
        }
        else {
            [path moveToPoint:pointWithOffset(CGPointMake(width - thick, halfHeight), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(thick, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, halfHeight), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(thick, height), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, height), offsetPoint)];
        }
    }
    else
    {
        if (direction == AnnexBezierPathArrowDirectionUp)
        {
            [path moveToPoint:pointWithOffset(CGPointMake(halfWidth, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, height - thick), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, height), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(halfWidth, thick), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, height), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, height - thick), offsetPoint)];
        }
        else
        {
            [path moveToPoint:pointWithOffset(CGPointMake(halfWidth, height - thick), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, 0.f), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(width, thick), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(halfWidth, height), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, thick), offsetPoint)];
            [path addLineToPoint:pointWithOffset(CGPointMake(0.f, 0.f), offsetPoint)];
        }
    }
    [path closePath];
    
    return path;
}

@end
