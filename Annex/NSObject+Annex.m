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

- (void)executeBlock:(void(^)(__weak id this))block queue:(dispatch_queue_t)queue withCallback:(void(^)(__weak id this))callback
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        
        block(weakSelf);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(weakSelf);
        });
    });
}

+ (void)executeBlock:(void(^)())block queue:(dispatch_queue_t)queue withCallback:(void(^)())callback
{
    dispatch_async(queue, ^{
        
        block();
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback();
        });
    });
    
}

- (void)executeBlock:(void(^)(__weak id this))block withCallback:(void(^)(__weak id this))callback
{
    [self executeBlock:block queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) withCallback:callback];
}

+ (void)executeBlock:(void(^)())block withCallback:(void(^)())callback
{
    [[self class] executeBlock:block queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) withCallback:callback];
}

- (void)executeBlock:(void(^)(__weak id this))block  queue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
    __weak typeof(self) weakSelf    = self;
    int64_t delta                   = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime         = dispatch_time(DISPATCH_TIME_NOW, delta);
    
    dispatch_after(popTime, queue, ^(void){
        block(weakSelf);
    });
    
}

+ (void)executeBlock:(void(^)())block  queue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay
{
    int64_t delta           = (int64_t)(1.0e9 * delay);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delta);
    
    dispatch_after(popTime, queue, ^(void){
        block();
    });
}

- (void)executeBlock:(void(^)(__weak id this))block afterDelay:(NSTimeInterval)delay
{
    [self executeBlock:block queue:dispatch_get_main_queue() afterDelay:delay];
}

+ (void)executeBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    [[self class] executeBlock:block queue:dispatch_get_main_queue() afterDelay:delay];
}

@end
