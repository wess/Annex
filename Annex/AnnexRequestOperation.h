//
//  AnnexRequestOperation.h
//  Annex
//
//  Created by Wess Cope on 9/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnexRequestOperation : NSOperation
- (instancetype)initWithRequest:(NSURLRequest *)request completionHandler:(void(^)(NSHTTPURLResponse *, NSData *, NSError *))handler;
+ (instancetype)operationWithRequest:(NSURLRequest *)request completionHandler:(void(^)(NSHTTPURLResponse *, NSData *, NSError *))handler;
@end
