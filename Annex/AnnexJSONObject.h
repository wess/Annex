//
//  AnnexJSONObject.h
//  Annex
//
//  Created by Wess Cope on 12/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnexJSONObject : NSObject<NSCopying>
@property (readonly, nonatomic) NSString *jsonString;
@property (readonly, nonatomic) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithJSONString:(NSString *)jsonString;
@end
