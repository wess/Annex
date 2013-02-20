//
//  NSDictionary+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSDictionary+Annex.h"

@implementation NSDictionary (Annex)
@dynamic jsonString;
@dynamic jsonData;
@dynamic httpQueryString;

- (NSString *)jsonString
{
    NSString *jsonString = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSData *)jsonData
{
    NSError *error      = nil;
    NSData *jsonData    = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    NSAssert(error == nil, @"toJSONData Error: %@", error.description);
    
    return jsonData;
}

- (NSString *)httpQueryString
{
    NSMutableArray *query = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [query addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    
    return [query componentsJoinedByString:@"&"];
}

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString
{
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONWritingPrettyPrinted error:&error];
    NSAssert(error == nil, @"DictionaryFromJSONString Error: %@", error.description);
    
    return result;    
}

@end
