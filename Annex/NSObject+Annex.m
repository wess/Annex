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

- (void)executeBlockInBackgroundWithWeakReference:(WeakReferencedBlock)block withCallback:(WeakReferencedBlock)callback
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        block(weakSelf);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(weakSelf);
        });
    });
}

+ (void)executeBlockInBackground:(VoidBlock)block withCallback:(VoidBlock)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        block();
        
        dispatch_async(dispatch_get_main_queue(), callback);
    });    
}

#pragma mark -
#pragma mark Background with Delay Methods

- (void)executeBlockInBackgroundWithWeakReference:(WeakReferencedBlock)block afterDelay:(NSTimeInterval)delay
{
    __weak typeof(self) weakSelf    = self;
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_after(popTime, queue, ^(void){
        block(weakSelf);
    });
}

+ (void)executeBlockInBackground:(VoidBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta           = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue	= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
    dispatch_after(popTime, queue, block);
}

#pragma mark -
#pragma mark Main Thread Methods

- (void)executeBlockOnMainThreadWithWeakReference:(WeakReferencedBlock)block
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

+ (void)executeBlockOnMainThread:(VoidBlock)block
{
	if ([NSThread isMainThread]) {
		block();
	} else {
		dispatch_async(dispatch_get_main_queue(), block);
	}
}

#pragma mark -
#pragma mark Main Thread with Delay Methods

- (void)executeBlockOnMainThreadWithWeakReference:(WeakReferencedBlock)block afterDelay:(NSTimeInterval)delay
{
	__weak typeof(self) weakSelf    = self;
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_main_queue();
	
	dispatch_after(popTime, queue, ^(void){
		block(weakSelf);
	});
}

+ (void)executeBlockOnMainThread:(VoidBlock)block afterDelay:(NSTimeInterval)delay
{
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
	dispatch_queue_t queue			= dispatch_get_main_queue();
	
	dispatch_after(popTime, queue, block);
}

@end
