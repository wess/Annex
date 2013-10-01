//
//  AnnexArrayController.h
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnexObjectController.h"

@interface AnnexArrayController : AnnexObjectController

//Managing Sort Descriptors
- (void)setSortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)sortDescriptors;

//Arranging Objects
- (NSArray *)arrangeObjects:(NSArray *)objects;
- (id)arrangedObjects;
- (void)rearrangeObjects;

//Managing Content
- (void)add:(id)sender;

//Selection Attributes
- (void)setAvoidsEmptySelection:(BOOL)flag;
- (BOOL)avoidsEmptySelection;
- (void)setClearsFilterPredicateOnInsertion:(BOOL)flag;
- (BOOL)preservesSelection;
- (void)setPreservesSelection:(BOOL)flag;
- (BOOL)alwaysUsesMultipleValuesMarker;
- (void)setAlwaysUsesMultipleValuesMarker:(BOOL)flag;

//Managing Selections
- (NSUInteger)selectionIndex;
- (BOOL)setSelectionIndex:(NSUInteger)index;
- (BOOL)selectsInsertedObjects;
- (void)setSelectsInsertedObjects:(BOOL)flag;
- (NSIndexSet *)selectionIndexes;
- (BOOL)setSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)addSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)removeSelectionIndexes:(NSIndexSet *)indexes;
- (BOOL)setSelectedObjects:(NSArray *)objects;
- (NSArray *)selectedObjects;
- (BOOL)addSelectedObjects:(NSArray *)objects;
- (BOOL)removeSelectedObjects:(NSArray *)objects;
- (void)selectNext:(id)sender;
- (BOOL)canSelectNext;
- (void)selectPrevious:(id)sender;
- (BOOL)canSelectPrevious;

//Inserting
- (BOOL)canInsert;
- (void)insert:(id)sender;

//Adding and Removing Objects
- (void)addObject:(id)object;
- (void)addObjects:(NSArray *)objects;
- (void)insertObject:(id)object atArrangedObjectIndex:(NSUInteger)index;
- (void)insertObjects:(NSArray *)objects atArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)removeObjectAtArrangedObjectIndex:(NSUInteger)index;
- (void)removeObjectsAtArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)remove:(id)sender;
- (void)removeObject:(id)object;
- (void)removeObjects:(NSArray *)objects;

//Filtering Content
- (BOOL)clearsFilterPredicateOnInsertion;
- (NSPredicate *)filterPredicate;
- (void)setFilterPredicate:(NSPredicate *)filterPredicate;

//Automatic Content Rearranging
- (void)setAutomaticallyRearrangesObjects:(BOOL)flag;
- (BOOL)automaticallyRearrangesObjects;

- (NSArray *)automaticRearrangementKeyPaths;
- (void)didChangeArrangementCriteria;
@end
