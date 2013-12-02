//
//  AnnexNetwork.m
//  Annex
//
//  Created by Wess Cope on 12/2/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexNetwork.h"
#import "NSURL+Annex.h"

@interface AnnexNetwork()

@end

@implementation AnnexNetwork
static NSString *httpQueryFromDictionary(NSDictionary *dict)
{
    __block NSMutableArray *strings = [[NSMutableArray alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *val, BOOL *stop) {
        [strings addObject:[NSString stringWithFormat:@"%@=%@", key, val]];
    }];
    
    return [strings componentsJoinedByString:@"&"];
}

+ (void)addRequest:(NSURLRequest *)request completionHandler:(AnnexRequestResponseBlock)handler
{
    AnnexRequestOperation *operation = [AnnexRequestOperation operationWithRequest:request completionHandler:handler];
    [operation start];
}

+ (void)getRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
{
    url = params? [url URLByAppendingParameters:params] : url;
    
    NSURLRequest *request   = [NSURLRequest requestWithURL:url];
    
    [AnnexNetwork addRequest:request completionHandler:handler];
}

+ (void)postRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
{
    NSString *bodyString            = httpQueryFromDictionary(params);
    NSMutableURLRequest *request    = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [AnnexNetwork addRequest:request completionHandler:handler];
}

+ (void)deleteRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
{
    url = params? [url URLByAppendingParameters:params] : url;
    
    NSMutableURLRequest *request   = [NSURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"delete"];
    
    [AnnexNetwork addRequest:request completionHandler:handler];
}

+ (void)putRequestWithURLString:(NSURL *)url params:(NSDictionary *)params completionHandler:(AnnexRequestResponseBlock)handler;
{
    NSString *bodyString            = httpQueryFromDictionary(params);
    NSMutableURLRequest *request    = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [AnnexNetwork addRequest:request completionHandler:handler];
}

@end
