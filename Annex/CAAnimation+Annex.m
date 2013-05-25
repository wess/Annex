//
//  CAAnimation+Annex.m
//  Easing
//
//  Created by Wess Cope on 5/24/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "CAAnimation+Annex.h"

AnnexEasingProperty AnnexEasingPropertyCreate(CGFloat time, CGFloat start, CGFloat delta, NSTimeInterval duration)
{
    AnnexEasingProperty property;
    property.time       = time;
    property.start      = start;
    property.delta      = delta;
    property.duration   = duration;
    
    return property;
}

@implementation CAAnimation (Annex)

+ (CAKeyframeAnimation *)animationForKeyPath:(NSString *)keyPath
                                withDuration:(NSTimeInterval)duration
                                        from:(NSTimeInterval)from
                                          to:(NSTimeInterval)to
                                 easingBlock:(AnnexEasingBlock)block;
{
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.removedOnCompletion   = NO;
    animation.fillMode              = kCAFillModeForwards;
    animation.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration              = duration;
    
    CGFloat frames          = 100.0f;
    NSMutableArray *values  = [[NSMutableArray alloc] initWithCapacity:frames];
    CGFloat delta           = to - from;
    
    for(NSInteger i = 0; i < frames; i++)
        [values addObject:@(block(AnnexEasingPropertyCreate((animation.duration * (i / frames)), from, delta, animation.duration)))];
    
    animation.values = values;
    
    return animation;
}

+ (void)addAnimationToLayer:(CALayer *)layer
                 forKeyPath:(NSString *)keyPath
               withDuration:(NSTimeInterval)duration
                         to:(NSTimeInterval)to
                easingBlock:(AnnexEasingBlock)block
{
    
    CAAnimation *animation = [self animationForKeyPath:keyPath
                                          withDuration:duration
                                                  from:[[layer valueForKeyPath:keyPath] floatValue]
                                                    to:to easingBlock:block];
    
    [layer addAnimation:animation forKey:nil];
}


+ (void)addAnimationToLayer:(CALayer *)layer
                 forKeyPath:(NSString *)keyPath
               withDuration:(NSTimeInterval)duration
                         to:(NSTimeInterval)to
                       from:(NSTimeInterval)from
                easingBlock:(AnnexEasingBlock)block
{
    CAAnimation *animation = [self animationForKeyPath:keyPath
                                          withDuration:duration
                                                  from:from
                                                    to:to
                                           easingBlock:block];
    
    [layer addAnimation:animation forKey:nil];
}


@end
