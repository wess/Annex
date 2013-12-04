//
//  NSNumber+Annex.h
//  Annex
//
//  Created by Wess Cope on 9/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Annex)
+ (NSNumber *)numberFromString:(NSString *)string withNumberStyle:(NSNumberFormatterStyle)style;
@end
