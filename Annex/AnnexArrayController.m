//
//  AnnexArrayController.m
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexArrayController.h"

@implementation AnnexArrayController
{
    void            *_reserved4;
	id              _rearrangementExtensions;
    NSMutableArray *_temporaryWorkObjects;
    
    struct __arrayControllerFlags
    {
        unsigned int _avoidsEmptySelection:1;
        unsigned int _preservesSelection:1;
        unsigned int _selectsInsertedObjects:1;
        unsigned int _alwaysUsesMultipleValuesMarker:1;
        unsigned int _refreshesAllModelObjects:1;
        unsigned int _filterRestrictsInsertion:1;
        unsigned int _overridesArrangeObjects:1;
        unsigned int _overridesDidChangeArrangementCriteria:1;
        unsigned int _explicitlyCannotInsert:1;
        unsigned int _generatedEmptyArray:1;
        unsigned int _isObservingKeyPathsThroughArrangedObjects:1;
        unsigned int _arrangedObjectsIsMutable:1;
        unsigned int _clearsFilterPredicateOnInsertion:1;
        unsigned int _skipSortingAfterFetch:1;
        unsigned int _automaticallyRearrangesObjects:1;
        unsigned int _reservedArrayController:17;
    } _arrayControllerFlags;

    NSUInteger          _observedIndexHint;
    NSMutableIndexSet   *_selectionIndexes;
    NSMutableArray      *_objects;
    NSIndexSet          *_cachedSelectedIndexes;
    NSArray             *_cachedSelectedObjects;
    NSArray             *_arrangedObjects;
}
@end
