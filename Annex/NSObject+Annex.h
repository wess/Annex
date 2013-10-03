//
//  NSObject+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Annex)

/** 
 `NSObject(Annex)` is an extension to NSObject with additional functionality.
 */

/**
 Executes a given block, followed by a callback, with a weak reference to the calling object;
 using a provided Queue.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted.
 */
- (void)executeBlock:(void(^)(__weak id this))block queue:(dispatch_queue_t)queue withCallback:(void(^)(__weak id this))callback;

/**
 Executes a given block, followed by a callback;
 using a provided Queue.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted.
 */
+ (void)executeBlock:(void(^)())block queue:(dispatch_queue_t)queue withCallback:(void(^)())callback;

/**
 Executes a given block, followed by a callback, with a weak reference to the calling object.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted.
 */
- (void)executeBlock:(void(^)(__weak id this))block withCallback:(void(^)(__weak id this))callback;

/**
 Executes a given block, followed by a callback.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted.
 */
+ (void)executeBlock:(void(^)())block withCallback:(void(^)())callback;

/**
 Executes a given block after a specificed delay, with a weak reference to the calling object;
 on the provided Queue.

 @param block   The code to be excuted
 @param delay   How long to wait before excuting block.
 */
- (void)executeBlock:(void(^)(__weak id this))block  queue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block after a specificed delay;  on the provided Queue.

 @param block   The code to be excuted
 @param delay   How long to wait before excuting block.
 */
+ (void)executeBlock:(void(^)())block  queue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block after a specificed delay, with a weak reference to the calling object.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block.
 */
- (void)executeBlock:(void(^)(__weak id this))block afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block after a specificed delay.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block.
 */
+ (void)executeBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;
@end
