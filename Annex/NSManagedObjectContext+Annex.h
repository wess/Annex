//
//  NSManagedObjectContext+Annex.h
//  Annex
//
//  Created by Wess Cope on 7/17/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 `NSManagedObjectContext(Annex)` is helper category for simplifying Core data fetch requests.
 */

@interface NSManagedObjectContext (Annex)

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectAllForEntityName:(NSString *)entityName;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     String of key to sort by or array of sort descriptors to sort against.
 @param     Direction to order the results.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectAllForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors ascending:(BOOL)ascending;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     Predicate used to filter the fetch against.
 @param     Indicate the order in which the results are sorted

 @note      If sortBy is an array of sort descriptiors, then ascending is ignored.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     Format to use to filter the fetch against.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectForEntityName:(NSString *)entityName withFormat:(NSString *)format, ...;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     String of key to sort by or array of sort descriptors to sort against.
 @param     Format to use to filter the fetch against.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withFormat:(NSString *)format, ...;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     String of key to sort by or array of sort descriptors to sort against.
 @param     Predicate used to filter the fetch request.

 @note      If sortBy is an array of sort descriptiors, then ascending is ignored. If sortBy is a string, ascending is defaulted to YES.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withPredicate:(NSPredicate *)predicate;

/**
 Fetches all objects from Core data for specified entity
 
 @param     Name of CoreData entity.
 @param     String of key to sort by or array of sort descriptors to sort against.
 @param     Predicate used to filter the fetch request.
 @param     Indicate the order in which the results are sorted

 @note      If sortBy is an array of sort descriptiors, then ascending is ignored.
 @return    Array of results from fetch request.
 */
- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withPredicate:(NSPredicate *)predicate ascending:(BOOL)ascending;
@end
