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

/**
 Iterates over the dictionary combining the result of the computation held in the
 dictionary with the object obj.

 @param obj Object to hold intermediate results with as we iterate.
 @param block Block to evaluate when combining reuslts.
 @return Object An object of the same type as obj after all combining is done.
 */
- (id)combineWithObject:(id)obj block:(id (^)(id, id<NSCopying>, id))block;

/**
 Maps objects in a dictionary using a block and returns array of newly mapped objects.
 
 @param block Called with every object inside the array and returns objject.
 @return Dictionary Created from self with objects processed with mapping block.
 */
- (NSDictionary*)mapObjectsAndKeysWithBlock:(id (^)(id<NSCopying> key, id object))block;

/**
 Removes all NSNull objects and invokes -withoutNulls on any object contained in
 the dictionary with the assumption that it will perform the same task: Iteratively
 remove NSNulls from the collection.

 @return Dictionary Derived from the receiver minus any NSNulls on all of its contents.
 */
- (instancetype)withoutNulls;

/**
 Returns the object with the key which is a a kind of a specific class.

 @param key Key of the item
 @param kind The kind of class we expect
 @return Object nil if the object at that given key is not of the right type
 */
- (id)objectForKey:(id)key ifKindOf:(Class)kind;

/**
 Returns the object with the key which is a a kind of a specific class or a default
 value if the type of class differs.

 @param key Key of the item
 @param kind The kind of class we expect
 @param defaultValue The default value to return if typechecking fails
 @return Object nil if the object at that given key is not of the right type
 */
- (id)objectForKey:(id)key ifKindOf:(Class)kind defaultValue:(id)defaultValue;

/**
 See arrayForKey:defaultValue: where defaultValue is empty array.
 */
- (NSArray*)arrayForKey:(id)key;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSDictionary.
 */
- (NSArray*)arrayForKey:(id)key defaultValue:(NSArray*)defaultValue;

/**
 See dictionaryForKey:defaultValue: where defaultValue is empty dictionary.
 */
- (NSDictionary*)dictionaryForKey:(id)key;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSDictionary.
 */
- (NSDictionary*)dictionaryForKey:(id)key defaultValue:(NSDictionary*)defaultValue;

/**
 See stringForKey:defaultValue: where defaultValue is empty string.
 */
- (NSString*)stringForKey:(id)key;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSString.
 */
- (NSString*)stringForKey:(id)key defaultValue:(NSString*)defaultValue;

/**
 See numberForKey:defaultValue: where defaultValue is nil.
 */
- (NSNumber*)numberForKey:(id)key;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSNumber.
 */
- (NSNumber*)numberForKey:(id)key defaultValue:(NSNumber*)defaultValue;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSNumber.
 */
- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue;

/**
 See dateForKey:defaultValue: where default value is nil.
 */
- (NSDate*)dateForKey:(id)key;

/**
 See objectForKey:ifKindOf:defaultValue: where kind is NSDate.
 */
- (NSDate*)dateForKey:(id)key defaultValue:(NSDate*)defaultValue;

@end
