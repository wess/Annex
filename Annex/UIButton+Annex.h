//
//  UIButton+Annex.h
//  Annex
//
//  Created by Wess Cope on 3/7/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Annex)
@property (strong, nonatomic) NSMutableDictionary *backgroundColors;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
