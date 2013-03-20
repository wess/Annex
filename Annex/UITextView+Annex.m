//
//  UITextView+Annex.m
//  Annex
//
//  Created by Wess Cope on 3/4/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UITextView+Annex.h"

@implementation UITextView (Annex)
@dynamic visibleTextRange;
@dynamic numberOfLines;

- (NSRange)visibleTextRange
{
    CGRect bounds           = self.bounds;
    NSString *text          = self.text;
    CGSize textSize         = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(bounds.size.width, bounds.size.height)];
    
    UITextPosition *start   = [self characterRangeAtPoint:bounds.origin].start;
    UITextPosition *end     = [self closestPositionToPoint:CGPointMake(textSize.width, textSize.height)];
    NSUInteger startPoint   = [self offsetFromPosition:self.beginningOfDocument toPosition:start];
    NSUInteger endPoint     = [self offsetFromPosition:start toPosition:end];
    
    return NSMakeRange(startPoint, endPoint);
}

- (NSUInteger)numberOfLines
{
    return (self.contentSize.height / self.font.lineHeight);
}

- (NSString *)textAtPoint:(CGPoint)point
{
    UITextPosition *textPosition    = [self closestPositionToPoint:point];
    UITextRange *textRange          = [self.tokenizer rangeEnclosingPosition:textPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    return [self textInRange:textRange];
}

- (NSDictionary *)attributesForTextAtPoint:(CGPoint)point
{
    if(!self.attributedText || ![self textAtPoint:point])
        return nil;
    
    UITextPosition *textPosition    = [self closestPositionToPoint:point];
    UITextRange *textRange          = [self.tokenizer rangeEnclosingPosition:textPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];

    NSInteger start = [self offsetFromPosition:self.beginningOfDocument toPosition:textRange.start];
    NSInteger end   = [self offsetFromPosition:self.beginningOfDocument toPosition:textRange.end];
    NSRange range   = NSMakeRange(start, (end - start));

    if(end < self.attributedText.length)
    {
    
        NSAttributedString *attributedSubString = [self.attributedText attributedSubstringFromRange:range];
        NSDictionary *attributes                = [attributedSubString attributesAtIndex:0 longestEffectiveRange:NULL inRange:NSMakeRange(0, attributedSubString.length)];
        
        return attributes;
    }
    
    return nil;
}

- (NSRange)rangeOfTextAtPoint:(CGPoint)point
{
    UITextPosition *textPosition    = [self closestPositionToPoint:point];
    UITextRange *textRange          = [self.tokenizer rangeEnclosingPosition:textPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    NSInteger start = [self offsetFromPosition:self.beginningOfDocument toPosition:textRange.start];
    NSInteger end   = [self offsetFromPosition:self.beginningOfDocument toPosition:textRange.end];
    NSRange range   = NSMakeRange(start, (end - start));

    return range;
}

@end
