//
//  NSObject+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AnnexWeakReferencedBlock)(__weak id this);
typedef void(^AnnexVoidBlock)(void);

@interface NSObject (Annex)

/**
 `NSObject(Annex)` is an extension to NSObject with additional functionality.
 */

/**
 Executes a given block in the background, followed by a callback on the main thread, with a weak reference to the calling object.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted.
 */
- (void)executeBlockInBackgroundWithWeakReference:(AnnexWeakReferencedBlock)block withCallback:(AnnexWeakReferencedBlock)callback;

/**
 Executes a given block, followed by a callback on the main thread.
 
 @param block       The code to be excuted
 @param callback    When the block is complete, the code that will be excuted on the main thread.
 */
+ (void)executeBlockInBackground:(AnnexVoidBlock)block withCallback:(AnnexVoidBlock)callback;

/**
 Executes a given block after a specificed delay, with a weak reference to the calling object.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block block in seconds.
 */
- (void)executeBlockInBackgroundWithWeakReference:(AnnexWeakReferencedBlock)block afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block after a specificed delay.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block block in seconds.
 */
+ (void)executeBlockInBackground:(AnnexVoidBlock)block afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block on the main thread, with a weak reference to the calling object.
 
 @param block       The code to be excuted
 */
- (void)executeBlockOnMainThreadWithWeakReference:(AnnexWeakReferencedBlock)block;

/**
 Executes a given block on the main thread.
 
 @param block       The code to be excuted
 */
+ (void)executeBlockOnMainThread:(AnnexVoidBlock)block;

/**
 Executes a given block on the main thread after a specificed delay, with a weak reference to the calling object.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block in seconds.
 */
- (void)executeBlockOnMainThreadWithWeakReference:(AnnexWeakReferencedBlock)block afterDelay:(NSTimeInterval)delay;

/**
 Executes a given block on the main thread after a specificed delay.
 
 @param block   The code to be excuted
 @param delay   How long to wait before excuting block block in seconds.
 */
+ (void)executeBlockOnMainThread:(AnnexVoidBlock)block afterDelay:(NSTimeInterval)delay;

@end

@interface NSObject (AnnexDeprecatedMethods)

- (void)executeBlock:(void(^)(__weak id this))block withCallback:(void(^)(__weak id this))callback __deprecated_msg("Use -executeBlockInBackgroundWithWeakReference:withCallback: instead.");
+ (void)executeBlock:(void(^)())block withCallback:(void(^)())callback __deprecated_msg("Use +executeBlockInBackground:withCallback: instead.");

- (void)executeBlock:(void(^)(__weak id this))block afterDelay:(NSTimeInterval)delay __deprecated_msg("Use -executeBlockInBackgroundWithWeakReference:afterDelay: instead.");
+ (void)executeBlock:(void(^)())block afterDelay:(NSTimeInterval)delay __deprecated_msg("Use +executeBlockInBackground:afterDelay: instead.");

@end
