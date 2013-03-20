//
//  UITextView+Annex.h
//  Annex
//
//  Created by Wess Cope on 3/4/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Annex)
/**
 `UITextView(Annex)` is an extension to UITextView with additional methods and attributes.
 */

/**
 Property to get the range of visible text.

 @return range of visible text.
 */
@property (readonly, nonatomic) NSRange visibleTextRange;

/**
 Property that gets total number of lines for total content.
 
 @return number of lines in content.
 */
@property (readonly, nonatomic) NSUInteger numberOfLines;

/**
 Finds and returns a string for a location inside the text view.
 
 @param point   Point inside the text view to look for text.
 
 @return        String found at point inside text view.
 */
- (NSString *)textAtPoint:(CGPoint)point;

/**
 Finds and returns attributes for the attributed substring.
 
 @param point   Point inside the text view for text.
 
 @return        Dictionary of attributes associated with attributed substring at point.
 */
- (NSDictionary *)attributesForTextAtPoint:(CGPoint)point;


/**
 Finds and returns range of text for a given point
 
 @param point   Point inside the text view for text.
 
 @return        Range of the text at point.
 */
- (NSRange)rangeOfTextAtPoint:(CGPoint)point;

@end
