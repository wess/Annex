//
//  AnnexImageCache.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexImageCache.h"
#import "AnnexRequestOperation.h"

@interface AnnexImageCache()
@property (strong, nonatomic) NSCache               *cache;
@property (strong, nonatomic) NSOperationQueue      *queue;

- (void)addOperationWithURL:(NSURL *)url completionHandler:(void(^)(UIImage *, NSError *))block;
- (void)imageFromURL:(NSURL *)url useCache:(BOOL)useCache completionHandler:(void(^)(UIImage *, NSError *))block;
+ (instancetype)instance;
@end

@implementation AnnexImageCache
static NSInteger        const AnnexImageCacheMaxConnections     = 5;
static NSString        *const AnnexImageCacheTimestampKey       = @"AnnexImageCacheTimestampKey";
static NSString        *const AnnexImageCacheImageKey           = @"AnnexImageCacheImageKey";
static NSString        *const AnnexImageCacheURLKey             = @"AnnexImageCacheURLKey";

+ (instancetype)instance
{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cache      = [[NSCache alloc] init];
        self.queue      = [[NSOperationQueue alloc] init];
        
        [self.queue setMaxConcurrentOperationCount:AnnexImageCacheMaxConnections];
    }
    return self;
}

- (void)addOperationWithURL:(NSURL *)url completionHandler:(void(^)(UIImage *, NSError *))block
{
    [self.queue addOperation:[AnnexRequestOperation operationWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        block((data? [UIImage imageWithData:data] : nil), error);
    }]];
}

- (void)imageFromURL:(NSURL *)url useCache:(BOOL)useCache completionHandler:(void(^)(UIImage *, NSError *))block
{
    if(useCache && [AnnexImageCache imageForKey:url.absoluteString])
    {
        block([AnnexImageCache imageForKey:url.absoluteString], nil);
        return;
    }
    
    [self addOperationWithURL:url completionHandler:block];
}

+ (UIImage *)imageForKey:(NSString *)key
{
    return [[[self instance] cache] objectForKey:key];
}

+ (void)imageFromURL:(NSURL *)url useCache:(BOOL)useCache completionHandler:(void(^)(UIImage *, NSError *))block
{
    [[self instance] imageFromURL:url useCache:useCache completionHandler:block];
}

+ (void)imageFromURL:(NSURL *)url completionHandler:(void(^)(UIImage *, NSError *))block
{
    [[self instance] imageFromURL:url useCache:YES completionHandler:block];
}

+ (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [[[self instance] cache] setObject:image forKey:key];
}

+ (void)setImageFromURL:(NSURL *)url forKey:(NSString *)key
{
    AnnexRequestOperation *operation = [AnnexRequestOperation operationWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        [AnnexImageCache setImage:(data? [UIImage imageWithData:data] : nil) forKey:key];
    }];
    
    [[[AnnexImageCache instance] queue] addOperation:operation];
}

+ (void)setImageFromURL:(NSURL *)url
{
    [AnnexImageCache setImageFromURL:url forKey:url.absoluteString];
}

+ (void)clearCache
{
    AnnexImageCache *this  = [AnnexImageCache instance];
    [this.cache removeAllObjects];
    [this.queue cancelAllOperations];
}


@end

