//
//  AnnexKeyChain.h
//  Annex
//
//  Created by Wess Cope on 3/8/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnexKeyChain : NSObject
@property (readonly, nonatomic) NSString      *service;

+ (instancetype)keyChainWithService:(NSString *)service;
- (instancetype)initWithService:(NSString *)service;
- (BOOL)hasValueForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

@end
