//
//  NSURL+Annex.h
//  Annex
//
//  Created by Wess Cope on 10/30/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Annex)
- (NSURL *)URLByAppendingQueryString:(NSString *)string;
- (NSURL *)URLByAppendingParameters:(NSDictionary *)params;
@end
