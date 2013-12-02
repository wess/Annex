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
+ (void)getRequestWithURL:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)postRequestWithURL:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)deleteRequestWithURL:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
+ (void)putRequestWithURL:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;

@end
