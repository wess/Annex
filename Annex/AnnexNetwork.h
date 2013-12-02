//
//  AnnexNetwork.h
//  Annex
//
//  Created by Wess Cope on 12/2/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnexRequestOperation.h"

@interface AnnexNetwork : NSObject
+ (void)getRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)postRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)deleteRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)putRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;

@end
