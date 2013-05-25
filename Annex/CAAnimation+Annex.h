//
//  CAAnimation+Annex.h
//  Easing
//
//  Created by Wess Cope on 5/24/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AnnexEasingBlocks.h"

@interface CAAnimation (Annex)

+ (CAKeyframeAnimation *)animationForKeyPath:(NSString *)keyPath
                                withDuration:(NSTimeInterval)duration
                                        from:(NSTimeInterval)from
                                          to:(NSTimeInterval)to
                                 easingBlock:(AnnexEasingBlock)block;

+ (void)addAnimationToLayer:(CALayer *)layer
                 forKeyPath:(NSString *)keyPath
               withDuration:(NSTimeInterval)duration
                         to:(NSTimeInterval)to
                easingBlock:(AnnexEasingBlock)block;

+ (void)addAnimationToLayer:(CALayer *)layer
                 forKeyPath:(NSString *)keyPath
               withDuration:(NSTimeInterval)duration
                         to:(NSTimeInterval)to
                       from:(NSTimeInterval)from
                easingBlock:(AnnexEasingBlock)block;
@end
