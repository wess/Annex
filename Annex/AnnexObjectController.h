//
//  AnnexObjectController.h
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnnexController.h"

@class NSFetchRequest, NSManagedObjectContext;

@interface AnnexObjectController : AnnexController
{
    void    *_reserved3;
    id      _managedProxy;
    
    struct __objectControllerFlags
    {
        unsigned int _editable:1;
        unsigned int _automaticallyPreparesContent:1;
        unsigned int _hasLoadedData:1;
        unsigned int _explicitlyCannotAdd:1;
        unsigned int _explicitlyCannotRemove:1;
        unsigned int _isUsingManagedProxy:1;
        unsigned int _hasFetched:1;
        unsigned int _batches:1;
        unsigned int _reservedObjectController:24;
    } _objectControllerFlags;

    NSString    *_objectClassName;
    Class       _objectClass;
    NSArray     *_contentObjectArray;
    id          _content;
    id          _objectHandler;
}

//Initializing an Object Controller
- (instancetype)initWithContent:(id)content;

//Managing Content
- (void)setContent:(id)content;
- (id)content;
- (void)setAutomaticallyPreparesContent:(BOOL)flag;
- (BOOL)automaticallyPreparesContent;
- (void)prepareContent;

//Setting the Content Class
- (void)setObjectClass:(Class)objectClass;
- (Class)objectClass;

//Managing Objects
- (id)newObject;
- (void)addObject:(id)object;
- (void)removeObject:(id)object;
- (void)add:(id)sender;
- (BOOL)canAdd;
- (void)remove:(id)sender;
- (BOOL)canRemove;

//Managing Editing
- (void)setEditable:(BOOL)flag;
- (BOOL)isEditable;

#ifdef NSCoreDataVersionNumber_iPhoneOS_5_0
//Core Data Support
– (NSString *)entityName;
– (void)setEntityName:(NSString *)name;
– (void)fetch:(id)sender;
- (void)setUsesLazyFetching:(BOOL)enabled;
- (BOOL)usesLazyFetching;
– (NSFetchRequest *)defaultFetchRequest;
– (NSPredicate *)fetchPredicate;
- (void)setFetchPredicate:(NSPredicate *)predicate;
- (NSManagedObjectContext *)managedObjectContext;
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (BOOL)fetchWithRequest:(NSFetchRequest *)fetchRequest merge:(BOOL)merge error:(NSError **)error;
#endif

//Obtaining Selections
- (NSArray *)selectedObjects;
- (id)selection;

//Validating User Interface Items
//- (BOOL)validateUserInterfaceItem:(id < NSValidatedUserInterfaceItem >)item;

@end
