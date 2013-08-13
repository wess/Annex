//
//  UIImage+Annex.h
//  Annex
//
//  Created by Wess Cope on 8/13/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Annex)
+ (UIImage *)fillImage:(UIImage *)image withColor:(UIColor *)color;
- (UIImage *)fillImageWithColor:(UIColor *)color;
@end
