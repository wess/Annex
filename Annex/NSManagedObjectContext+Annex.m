//
//  NSManagedObjectContext+Annex.m
//  Annex
//
//  Created by Wess Cope on 7/17/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "NSManagedObjectContext+Annex.h"

@implementation NSManagedObjectContext (Annex)
- (NSArray *)selectAllForEntityName:(NSString *)entityName
{
    return [self selectForEntityName:entityName sortBy:nil withPredicate:nil];
}

- (NSArray *)selectAllForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors ascending:(BOOL)ascending
{
    return [self selectForEntityName:entityName sortBy:keyOrSortDescriptors withPredicate:nil];
}

- (NSArray *)selectForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
    return [self selectForEntityName:entityName sortBy:nil withPredicate:predicate];
}

- (NSArray *)selectForEntityName:(NSString *)entityName withFormat:(NSString *)format, ...
{
    va_list arguments;
    va_start(arguments, format);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format arguments:arguments];
    
    va_end(arguments);
    
    return [self selectForEntityName:entityName sortBy:nil withPredicate:predicate];
}

- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withFormat:(NSString *)format, ...
{
    va_list arguments;
    va_start(arguments, format);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format arguments:arguments];
    
    va_end(arguments);
    
    return [self selectForEntityName:entityName sortBy:keyOrSortDescriptors withPredicate:predicate];
}

- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withPredicate:(NSPredicate *)predicate
{
    return [self selectForEntityName:entityName sortBy:keyOrSortDescriptors withPredicate:predicate ascending:YES];
}

- (NSArray *)selectForEntityName:(NSString *)entityName sortBy:(id)keyOrSortDescriptors withPredicate:(NSPredicate *)predicate ascending:(BOOL)ascending
{
    NSEntityDescription *entityDescription  = [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
    NSFetchRequest *fetchRequest            = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = entityDescription;
    
    if(keyOrSortDescriptors)
    {
        if([keyOrSortDescriptors isKindOfClass:[NSArray class]])
            fetchRequest.sortDescriptors = keyOrSortDescriptors;
        else if([keyOrSortDescriptors isKindOfClass:[NSString class]])
            fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:((NSString *)keyOrSortDescriptors) ascending:ascending]];
    }
    
    if(predicate)
    {
        fetchRequest.predicate = predicate;
    }
    
    NSError *error = nil;
    NSArray *results = [self executeFetchRequest:fetchRequest error:&error];
    
    NSAssert(error == nil, error.debugDescription);
    
    return results;
}
@end
