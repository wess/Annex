//
//  AnnexKeyChain.m
//  Annex
//
//  Created by Wess Cope on 3/8/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexKeyChain.h"
#import "Annex.h"

@interface AnnexKeyChain()
@property (readonly, nonatomic) NSString *secService;
- (void)saveObject:(id)value forKey:(NSString *)key;
- (id)getObjectForKey:(NSString *)key;
@end

@implementation AnnexKeyChain
static NSString *const AnnexKeyChainSelectorSuffix = @":";
static NSString *defaultService;

@synthesize service     = _service;

NSMutableDictionary *optionsDictionary(NSString *key, NSString *service)
{
    return [@{
            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecAttrService : (service && service.length > 0? service : defaultService),
            (__bridge id)kSecAttrAccount : key
            } mutableCopy];
}


OSStatus valueStatusForKey(NSString *key, NSString *service)
{
    NSDictionary *searchDictionary = optionsDictionary(key, (service && service.length > 0? service : defaultService));
    return SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, nil);
}

- (void)setup
{
    defaultService = [NSString stringWithFormat:@"com.%@", AnnexAppName];
}

- (instancetype)initWithService:(NSString *)service
{
    self = [super init];
    if (self)
    {
        [self setup];
        _service = [service copy];
    }
    return self;
}

+ (instancetype)keyChainWithService:(NSString *)service
{
    AnnexKeyChain *keychain = [[AnnexKeyChain alloc] initWithService:service];
    return keychain;
}

- (NSString *)secService
{
    return (_service && _service.length > 0)? _service : defaultService;
}

- (void)removeObjectForKey:(NSString *)key
{
    NSDictionary *query = optionsDictionary(key, self.secService);
    SecItemDelete((__bridge CFDictionaryRef)query);
}


#pragma mark - Invocation Magic -
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(aSelector == nil)
    {
        NSString *selectorName  = [NSStringFromSelector(aSelector) lowercaseString];
        signature               = [NSMethodSignature signatureWithObjCTypes:(([selectorName hasSuffix:AnnexKeyChainSelectorSuffix])? "v@:@" : "@@:")];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selectorName = [NSStringFromSelector([anInvocation selector]) lowercaseString];
    if([selectorName hasSuffix:AnnexKeyChainSelectorSuffix])
    {
        NSString *property = [selectorName substringWithRange:NSMakeRange(3, selectorName.length - 4)];
        id invocationValue;
        [anInvocation getArgument:&invocationValue atIndex:2];

        [self saveObject:invocationValue forKey:property];
    }
    else
    {
        id returnValue = [self getObjectForKey:selectorName];
        [anInvocation setReturnValue:&returnValue];
    }
}

- (void)saveObject:(id)value forKey:(NSString *)key
{
    NSData *data        = [NSKeyedArchiver archivedDataWithRootObject:value];
    OSStatus valStatus  = valueStatusForKey(key, self.secService);
    
    NSMutableDictionary *queryDict = optionsDictionary(key, self.secService);

    if(valStatus == errSecItemNotFound)
    {
        [queryDict setObject:data forKey:(__bridge id)kSecValueData];
        
        valStatus = SecItemAdd((__bridge CFDictionaryRef)queryDict, NULL);
        NSAssert1(valStatus == errSecSuccess, @"Value add returned status: %zd", valStatus);
    }
    else if(valStatus == errSecSuccess)
    {
        NSDictionary *valueDict = @{(__bridge id)kSecValueData: data};

        valStatus = SecItemUpdate((__bridge CFDictionaryRef)queryDict, (__bridge CFDictionaryRef)valueDict);
        NSAssert1(valStatus == errSecSuccess, @"Value add returned status: %zd", valStatus);
    }
}

- (id)getObjectForKey:(NSString *)key
{
    NSMutableDictionary *retrieveQuery = optionsDictionary(key, self.secService);
    [retrieveQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef dataRef   = nil;
    OSStatus query      = SecItemCopyMatching((__bridge CFDictionaryRef)retrieveQuery, (CFTypeRef *)&dataRef);
    
    if(query == errSecSuccess)
    {
        NSData *data = (__bridge NSData *)dataRef;
        
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return nil;
}

- (BOOL)hasValueForKey:(NSString *)key
{
    return (valueStatusForKey(key, self.secService) == errSecSuccess);
}

@end
