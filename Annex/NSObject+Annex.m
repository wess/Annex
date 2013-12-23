//
//  NSObject+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSObject+Annex.h"
#import <objc/runtime.h>

@implementation NSObject (Annex)

#pragma mark -
#pragma mark Background Methods

- (void)executeBlockInBackgroundWithWeakReference:(AnnexWeakReferencedBlock)block withCallback:(AnnexWeakReferencedBlock)callback
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        block(weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(weakSelf);
        });
    });
}

+ (void)executeBlockInBackground:(AnnexVoidBlock)block withCallback:(AnnexVoidBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        block();
        
        dispatch_async(dispatch_get_main_queue(), callback);
    });    
}

#pragma mark -
#pragma mark Background with Delay Methods

- (void)executeBlockInBackgroundWithWeakReference:(AnnexWeakReferencedBlock)block afterDelay:(NSTimeInterval)delay
{
    __weak typeof(self) weakSelf    = self;
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(popTime, queue, ^(void){
        block(weakSelf);
    });
}

+ (void)executeBlockInBackground:(AnnexVoidBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta           = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue	= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
    dispatch_after(popTime, queue, block);
}

#pragma mark -
#pragma mark Main Thread Methods

- (void)executeBlockOnMainThreadWithWeakReference:(AnnexWeakReferencedBlock)block
{
	__weak typeof(self) weakSelf = self;
	
	if ([NSThread isMainThread]) {
		block(weakSelf);
	} else {
		dispatch_async(dispatch_get_main_queue(), ^{
			block(weakSelf);
		});
	}
}

+ (void)executeBlockOnMainThread:(AnnexVoidBlock)block
{
	if ([NSThread isMainThread]) {
		block();
	} else {
		dispatch_async(dispatch_get_main_queue(), block);
	}
}

#pragma mark -
#pragma mark Main Thread with Delay Methods

- (void)executeBlockOnMainThreadWithWeakReference:(AnnexWeakReferencedBlock)block afterDelay:(NSTimeInterval)delay
{
	__weak typeof(self) weakSelf    = self;
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_main_queue();
	
	dispatch_after(popTime, queue, ^(void){
		block(weakSelf);
	});
}

+ (void)executeBlockOnMainThread:(AnnexVoidBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_main_queue();
	
	dispatch_after(popTime, queue, block);
}

@end

#pragma mark -
#pragma mark Deprecated Methods (For Backwards Compatibility)

@implementation NSObject (AnnexDeprecatedMethods)

- (void)executeBlock:(void(^)(__weak id this))block withCallback:(void(^)(__weak id this))callback
{
	[self executeBlockInBackgroundWithWeakReference:block withCallback:callback];
}

+ (void)executeBlock:(void(^)())block withCallback:(void(^)())callback
{
	[self executeBlockInBackground:block withCallback:callback];
}

- (void)executeBlock:(void(^)(__weak id this))block afterDelay:(NSTimeInterval)delay
{
	[self executeBlockInBackgroundWithWeakReference:block afterDelay:delay];
}

+ (void)executeBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
	[self executeBlockInBackground:block afterDelay:delay];
}

@end
