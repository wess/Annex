//
//  AnnexImageCache.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Callback used when image request has been completed.
 */
typedef void(^AnnexImageCacheBlock)(UIImage *, NSError *);

@interface AnnexImageCache : NSObject
/**
 `AnnexImageCache` is a lightweight class for managing image requests and caching.
 */

/**
 Returns an image from the cache based on the provided key (name).
 
 @param NSString Key (named) used with storing image to cache.
 @return UIImage Image stored in cache, or nil of does not exsist.
 */
+ (UIImage *)imageForKey:(NSString *)key;

/**
 Loads an image asyncronously from provided URL.
 
 @param NSURL                   URL of image to load.
 @param AnnexImageCacheBlock    Block called when request has completed.
 */
+ (void)imageFromURL:(NSURL *)url onCompletion:(AnnexImageCacheBlock)block;

/**
 Inserts or overwrites image in cache for provided key.
 
 @param UIImage Image to cache.
 @param NSString Key (name) to associate with image.
 */
+ (void)setImage:(UIImage *)image forKey:(NSString *)key;

/**
 Inserts image into cache asyncronously from URL request.
 
 @param NSURL       URL for image to request.
 @param NSString    Key (name) to associate with image loaded from url.
 */
+ (void)setImageFromURL:(NSURL *)url forKey:(NSString *)key;

/**
 Inserts image into cache asyncronously, using the url as the key(name) to associate with request image.
 
 @param NSURL URL of image to request and cache.
 */

+ (void)setImageFromURL:(NSURL *)url;

/**
 Clears all images and details from cache.
 */
+ (void)clearCache;
@end
