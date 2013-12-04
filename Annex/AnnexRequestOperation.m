//
//  AnnexRequestOperation.m
//  Annex
//
//  Created by Wess Cope on 9/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexRequestOperation.h"

@interface AnnexRequestOperation()
@property (strong, nonatomic)   NSURLConnection             *connection;
@property (strong, nonatomic)   NSURLRequest                *request;
@property (strong, nonatomic)   NSHTTPURLResponse           *response;
@property (strong, nonatomic)   NSError                     *error;
@property (strong, nonatomic)   NSMutableData               *receivedData;
@property (copy, nonatomic)     AnnexRequestResponseBlock   handler;
@property BOOL isExecuting;
@property BOOL isFinished;

- (void)requestCompleted;

@end

@implementation AnnexRequestOperation

+ (instancetype)operationWithRequest:(NSURLRequest *)request completionHandler:(AnnexRequestResponseBlock)handler;
{
    return [[AnnexRequestOperation alloc] initWithRequest:request completionHandler:handler];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    return ([key isEqualToString:@"isExecuting"] || [key isEqualToString:@"isFinished"])? YES : [super automaticallyNotifiesObserversForKey:key];
}

- (instancetype)initWithRequest:(NSURLRequest *)request completionHandler:(AnnexRequestResponseBlock)handler;
{
    self = [super init];
    if(self)
    {
        self.request    = request;
        self.error      = nil;
        self.response   = nil;
        self.handler    = handler;
    }
    return self;
}

- (void)requestCompleted
{
    self.isFinished = YES;
    self.isExecuting = NO;
    
    if(_handler)
        _handler(self.response, [self.receivedData copy], self.error);
}

- (BOOL)isConcurrent
{
    return YES;
}

#pragma mark - NSOperation Overrides -
- (void)start
{

    NSAssert(self.request != nil, @"AnnexRequestOperation requires NSURLRequest");
    
    if(self.isCancelled)
    {
        self.isExecuting    = NO;
        self.isFinished     = YES;
        
        return;
    }
    
    self.receivedData   = [[NSMutableData alloc] init];
    self.isExecuting    = YES;
    self.connection     = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];

    [self.connection start];

    while(self.isExecuting)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
}

#pragma mark - NSSURLConnection Delegate -
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(!self.isCancelled)
    {
        [self.receivedData appendData:data];
        return;
    }
    
    self.isFinished     = YES;
    self.isExecuting    = NO;
    
    [self.connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.response           = (NSHTTPURLResponse *)response;
    NSInteger statusCode    = self.response.statusCode;
    
    if(statusCode > 199 && statusCode < 400)
        return;
    
    if(statusCode > 399)
    {
        self.error = [NSError errorWithDomain:NSURLErrorDomain code:statusCode userInfo:@{NSURLErrorFailingURLErrorKey: self.request.URL}];
        [self requestCompleted];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.error = error;
    [self requestCompleted];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self requestCompleted];
}

@end
