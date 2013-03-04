//
//  UITextView+Annex.m
//  Annex
//
//  Created by Wess Cope on 3/4/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UITextView+Annex.h"

@implementation UITextView (Annex)
- (NSString *)textAtPoint:(CGPoint)point
{
    UITextPosition *textPosition    = [self closestPositionToPoint:point];
    UITextRange *textRange          = [self.tokenizer rangeEnclosingPosition:textPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    return [self textInRange:textRange];
}
@end
