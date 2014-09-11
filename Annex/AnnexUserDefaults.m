//
//  AnnexUserDefaults.m
//  Annex
//
//  Created by Wess Cope on 4/28/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "AnnexUserDefaults.h"

@interface AnnexUserDefaults()
- (void)saveDefault:(id)obj forKey:(NSString *)key;
- (id)defaultForKey:(NSString *)key;
@end

@implementation AnnexUserDefaults
static NSString *const SelectorSuffix = @":";

+ (instancetype) instance
{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    
    return _instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if(![self respondsToSelector:aSelector])
    {
        NSString *selectorName  = [NSStringFromSelector(aSelector) lowercaseString];
        signature               = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:SelectorSuffix])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selectorName = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    
    if([selectorName hasSuffix:SelectorSuffix])
    {
        NSString *property = [selectorName substringWithRange:NSMakeRange(3, selectorName.length - 4)];
        id invocationValue;
        [anInvocation getArgument:&invocationValue atIndex:2];
        [self saveDefault:invocationValue forKey:property];
    }
    else
    {
        id returnValue = [self defaultForKey:selectorName];
        [anInvocation setReturnValue:&returnValue];
    }
}

- (void)saveDefault:(id)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)defaultForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
