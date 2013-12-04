//
//  NSURL+Annex.m
//  Annex
//
//  Created by Wess Cope on 10/30/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSURL+Annex.h"
#import "NSDictionary+Annex.h"

@implementation NSURL (Annex)
- (NSURL *)URLByAppendingQueryString:(NSString *)string
{
    NSString *urlString = [self.absoluteString stringByAppendingString:[NSString stringWithFormat:@"?%@", string]];
    
    return [NSURL URLWithString:urlString];
}

- (NSURL *)URLByAppendingParameters:(NSDictionary *)params
{
    return [self URLByAppendingQueryString:[params httpQueryString]];
}

@end
