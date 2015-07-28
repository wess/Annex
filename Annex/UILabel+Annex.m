//
//  UILabel+Annex.m
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import "UILabel+Annex.h"

@implementation UILabel (Annex)
- (CGSize)suggestedSizeForWidth:(CGFloat)width
{
    return (self.attributedText)? [self suggestSizeForAttributedString:self.attributedText width:width] : [self suggestSizeForString:self.text width:width];
}

- (CGSize)suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width
{
    return (!string)? CGSizeZero : [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)suggestSizeForString:(NSString *)string width:(CGFloat)width
{
    return (!string)? CGSizeZero : [self suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
