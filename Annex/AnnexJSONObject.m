//
//  AnnexJSONObject.m
//  Annex
//
//  Created by Wess Cope on 12/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexJSONObject.h"
#import "NSDictionary+Annex.h"

@interface AnnexJSONObject()
@property (strong, nonatomic) NSDictionary *jsonDictionary;

- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;
- (void)saveObject:(id)value forKey:(NSString *)key;
- (id)getObjectForKey:(NSString *)key;
@end

@implementation AnnexJSONObject
static NSString *const AnnexJSONObjectSelectorSuffix = @":";

@synthesize jsonString  = _jsonString;
@synthesize dictionary  = _dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSParameterAssert(dictionary);
    
    self = [super init];
    if(self)
    {
        self.jsonDictionary = [dictionary copy];
    }
    return self;
}

- (instancetype)initWithJSONString:(NSString *)jsonString
{
    NSParameterAssert(jsonString);
    return [[[self class] alloc] initWithDictionary:[NSDictionary dictionaryFromJSONString:jsonString]];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithDictionary:self.jsonDictionary copyItems:YES];
}

- (NSString *)jsonString
{
    return _dictionary == nil? nil : [_dictionary jsonString];
}

- (NSDictionary *)dictionary
{
    return [self.jsonDictionary copy];
}

#pragma mark - Invocation Love -
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(aSelector == nil)
    {
        NSString *selectorName  = [NSStringFromSelector(aSelector) lowercaseString];
        signature               = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:AnnexJSONObjectSelectorSuffix])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *name = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    if([name hasSuffix:AnnexJSONObjectSelectorSuffix])
    {
        NSString *property = [name substringWithRange:NSMakeRange(3, name.length - 4)];
        id value;
     
        [anInvocation getArgument:&value atIndex:2];
        [self saveObject:value forKey:property];
    }
    else
    {
        id returnValue = [self getObjectForKey:name];
        [anInvocation setReturnValue:&returnValue];
    }
}

#pragma mark - Invocation Accessors -
- (void)setValue:(id)value forKey:(NSString *)key
{
    NSMutableDictionary *dictionary = [self.jsonDictionary mutableCopy];

    [dictionary setValue:value forKey:key];
    
    self.jsonDictionary = [dictionary copy];
}

- (id)valueForKey:(NSString *)key
{
    return [self.jsonDictionary valueForKey:key];
}

- (void)saveObject:(id)value forKey:(NSString *)key
{
    NSMutableDictionary *dictionary = [self.jsonDictionary mutableCopy];
    dictionary[key] = value;
    
    self.jsonDictionary = [dictionary copy];
}

- (id)getObjectForKey:(NSString *)key
{
    return [self.jsonDictionary objectForKey:key];
}


@end
