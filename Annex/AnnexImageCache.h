//
//  AnnexImageCache.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AnnexImageCacheBlock)(UIImage *, NSError *);

@interface AnnexImageCacheOperation : NSOperation
+ (instancetype)imageCacheOperationWithURL:(NSURL *)url completion:(AnnexImageCacheBlock)block;
@end

@interface AnnexImageCache : NSObject
+ (UIImage *)imageForKey:(NSString *)key;
+ (void)imageFromURL:(NSURL *)url completion:(AnnexImageCacheBlock)block;
+ (void)setImage:(UIImage *)image forKey:(NSString *)key;
+ (void)setImageFromURL:(NSURL *)url forKey:(NSString *)key;
+ (void)setImageFromURL:(NSURL *)url;
+ (void)clearCache;
@end
