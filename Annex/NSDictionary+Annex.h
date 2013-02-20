//
//  NSDictionary+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Annex)
/**
 `NSDictionary(Annax)` is an extension to NSDictionary with additional functionality.
 */

/**
 Property to access a json string representation of a dictionary
 */
@property (readonly, nonatomic) NSString    *jsonString;

/**
 Property to access a json data representation of a dictionary
 */
@property (readonly, nonatomic) NSData      *jsonData;

/**
 Property to access a string that is a http query representation
 */
@property (readonly, nonatomic) NSString    *httpQueryString;

/**
 Creates a dictionary from a JSON string
 
 @param jsonString JSON string to convert into a dictionary
 @return Dictionary created from string.
 */
+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString;

@end
