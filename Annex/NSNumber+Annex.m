//
//  NSNumber+Annex.m
//  Annex
//
//  Created by Wess Cope on 9/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSNumber+Annex.h"

@implementation NSNumber (Annex)
+ (NSNumber *)numberFromString:(NSString *)string withNumberStyle:(NSNumberFormatterStyle)style
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = style;
    
    return [formatter numberFromString:string];
}
@end
