//
//  NSArray+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/25/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Annex)
/**
 `NSArray(Annex)` is an extension to NSArray with additional functionality.
 */

/**
 Iterates over the array combining the result of the computation held in the
 array with the object obj.

 @param obj Object to hold intermediate results with as we iterate.
 @param block Block to evaluate when combining reuslts.
 @return Object An object of the same type as obj after all combining is done.
 */
- (id)combineWithObject:(id)obj block:(id (^)(id, id))block;

/**
 Maps objects in an array using a block and returns array of newly mapped objects.
 
 @param Block Called with every object inside the array and returns objject.
 @return Array Created from self with objects processed with mapping block.
 */
- (NSArray *)mapObjectsWithBlock:(id(^)(id object))block;

/**
 Removes all NSNull objects and invokes -withoutNulls on any object contained in
 the array with the assumption that it will perform the same task: Iteratively
 remove NSNulls from the collection.

 @return Array Derived from the receiver minus any NSNulls on all of its contents.
 */
- (instancetype)withoutNulls;

/**
 Removes all instances of aClass from the collection.

 @param Class The class to remove from the array.
 @return Array Derived from the receiver without any instance of aClass
 */
- (instancetype)arrayByRemovingObjectsOfClass:(Class)aClass;

/**
 Returns the object at the index which is a a kind of a specific class.

 @param NSUInteger Index of the item
 @param Class The kind of class we expect
 @return Object nil if the object at that given index is not of the right type
 */
- (id)objectAtIndex:(NSUInteger)index ifKindOf:(Class)kind;

/**
 Returns the object at the index which is a a kind of a specific class or a default
 value if the type of class differs.

 @param NSUInteger Index of the item
 @param Class The kind of class we expect
 @param Object The default value to return if typechecking fails
 @return Object nil if the object at that given index is not of the right type
 */
- (id)objectAtIndex:(NSUInteger)index ifKindOf:(Class)kind defaultValue:(id)defaultValue;

/**
 See objectAtIndex:ifKindOf:. The class is typed staitcally to be an NSArray
 with a default value of empty array.
 */
- (NSArray*)arrayAtIndex:(NSUInteger)index;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSArray.
 */
- (NSArray*)arrayAtIndex:(NSUInteger)index defaultValue:(NSArray*)defaultValue;

/**
 See objectAtIndex:ifKindOf:. The class is typed staitcally to be an NSDictionary
 with a default value of empty dictionary.
 */
- (NSDictionary*)dictionaryAtIndex:(NSUInteger)index;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSDictionary.
 */
- (NSDictionary*)dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary*)defaultValue;

/**
 See objectAtIndex:ifKindOf:. The class is typed staitcally to be an NSString
 with a default value of empty string.
 */
- (NSString*)stringAtIndex:(NSUInteger)index;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSString.
 */
- (NSString*)stringAtIndex:(NSUInteger)index defaultValue:(NSString*)defaultValue;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed staitcally to be
 an NSNumber with a default value of nil.
 */
- (NSNumber*)numberAtIndex:(NSUInteger)index;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSNumber.
 */
- (NSNumber*)numberAtIndex:(NSUInteger)index defaultValue:(NSNumber*)defaultValue;

/** -boolAtIndex: is not provided. You are the owner of your default value mistakes. */
/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSNumber.
 */
- (BOOL)boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed staitcally to be
 an NSDate with a default value of nil.

 @param NSUInteger Index to look for an NSDate.
 @return Object nil if there's no NSDate at the given index, otherwise the date
 */
- (NSDate*)dateAtIndex:(NSUInteger)index;

/**
 See objectAtIndex:ifKindOf:defaultValue:. The class is typed statically to be
 an NSDate.
 */
- (NSDate*)dateAtIndex:(NSUInteger)index defaultValue:(NSDate*)defaultValue;

- (instancetype)filterObjectsUsingBlock:(BOOL (^)(id))block;
@end
