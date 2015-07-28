//
//  UILabel+Annex.h
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Annex)
/**
 Gets suggested size for label, label's text, with in the provided width.
 
 @param width   Width to constrain suggested size to.
 @return        Size suggested for label content, for width.
 */
- (CGSize)suggestedSizeForWidth:(CGFloat)width;

/**
 Gets suggested size for attributedString constrainted to width.
 
 @param string  AttributedString for determining size.
 @param width   Width to constrain suggested size to.
 @return        Size suggested for label content, for width.
 */
- (CGSize)suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;

/**
 Gets suggested size for string constrainted to width.
 
 @param string  AttributedString for determining size.
 @param width   Width to constrain suggested size to.
 @return        Size suggested for label content, for width.
 */
- (CGSize)suggestSizeForString:(NSString *)string width:(CGFloat)width;
@end
