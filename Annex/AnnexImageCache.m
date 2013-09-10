//
//  AnnexImageCache.m
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexImageCache.h"
#import <CoreData/CoreDataDefines.h>

@interface AnnexImageCacheOperation : NSOperation
+ (instancetype)imageCacheOperationWithURL:(NSURL *)url completion:(AnnexImageCacheBlock)block;
@end

@interface AnnexImageCacheOperation()
@property (strong, nonatomic) UIImage           *image;
@property (strong, nonatomic) NSURL             *url;
@property (copy, nonatomic) AnnexImageCacheBlock block;

@end

@implementation AnnexImageCacheOperation

+ (instancetype)imageCacheOperationWithURL:(NSURL *)url completion:(AnnexImageCacheBlock)block
{
    AnnexImageCacheOperation *operation = [[AnnexImageCacheOperation alloc] init];
    operation.block                     = block;
    operation.url                       = url;
    
    return operation;
}

- (void)main
{
    NSError *error                  = nil;
    NSMutableURLRequest *request    = [NSMutableURLRequest requestWithURL:self.url];
    NSHTTPURLResponse *response     = [[NSHTTPURLResponse alloc] init];
    NSData *data                    = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    UIImage *image                  = [UIImage imageWithData:data];
    
    self.block(image, error);
}

@end

@interface AnnexImageCache()
@property (strong, nonatomic) NSMutableDictionary   *dictionary;
@property (strong, nonatomic) NSOperationQueue      *queue;

+ (instancetype)instance;
@end

@implementation AnnexImageCache
static NSTimeInterval   const AnnexImageCacheTimeoutInterval    = 10;
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
        self.dictionary = [[NSMutableDictionary alloc] init];
        self.queue      = [[NSOperationQueue alloc] init];
        
        [self.queue setMaxConcurrentOperationCount:AnnexImageCacheMaxConnections];
    }
    return self;
}

+ (UIImage *)imageForKey:(NSString *)key
{
    AnnexImageCache *cache = [AnnexImageCache instance];
    if(cache.dictionary[key])
    {
        cache.dictionary[key][AnnexImageCacheTimestampKey] = [NSDate date];

        return cache.dictionary[key];
    }
    
    return nil;
}

+ (void)imageFromURL:(NSURL *)url completion:(AnnexImageCacheBlock)block
{
    AnnexImageCacheOperation *operation = [AnnexImageCacheOperation imageCacheOperationWithURL:url completion:block];
    [[AnnexImageCache instance].queue addOperation:operation];
}

+ (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    AnnexImageCache *cache          = [AnnexImageCache instance];
    NSMutableDictionary *dictionary = [@{AnnexImageCacheImageKey: image, AnnexImageCacheTimestampKey: [NSDate date]} mutableCopy];
    cache.dictionary[key]           = dictionary;
}

+ (void)setImageFromURL:(NSURL *)url forKey:(NSString *)key
{
    AnnexImageCacheOperation *operation = [AnnexImageCacheOperation imageCacheOperationWithURL:url completion:^(UIImage *image, NSError *error) {
        [AnnexImageCache setImage:image forKey:key];
    }];
    
    AnnexImageCache *cache = [AnnexImageCache instance];
    [cache.queue addOperation:operation];
}

+ (void)setImageFromURL:(NSURL *)url
{
    [AnnexImageCache setImageFromURL:url forKey:url.absoluteString];
}

+ (void)clearCache
{
    AnnexImageCache *cache  = [AnnexImageCache instance];
    cache.dictionary        = [[NSMutableDictionary alloc] init];

    [cache.dictionary removeAllObjects];
}


@end

