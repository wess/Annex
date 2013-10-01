//
//  AnnexController.m
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexController.h"
#import "Exception.h"

id AnnexNoSelectionMarker   = @"AnnexNoSelectionMarker";
id AnnexMultipleValueMarker = @"AnnexMultipleValueMarker";
id AnnexNotApplicableMarker = @"AnnexNotApplicableMarker";

@implementation AnnexController
{
    NSMutableArray *_editors;
}

static BOOL isControllerMarker(id object)
{
    return ([object isEqualToString:AnnexNoSelectionMarker] || [object isEqualToString:AnnexMultipleValueMarker] || [object isEqualToString:AnnexNotApplicableMarker]);
}

+ (void)initialize
{
    if(self == [AnnexController class])
    {
        AnnexNoSelectionMarker   = @"AnnexNoSelectionMarker";
        AnnexMultipleValueMarker = @"AnnexMultipleValueMarker";
        AnnexNotApplicableMarker = @"AnnexNotApplicableMarker";
    }
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    _editors = nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    AnnexUnimplementedMethod();
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    AnnexUnimplementedMethod();
}

- (BOOL)commitEditing
{
    if(_editors.count == 0)
        return YES;
    
    __block BOOL response = YES;
    [_editors enumerateObjectsUsingBlock:^(id editor, NSUInteger idx, BOOL *stop) {
        if([editor commitEditing] == NO)
        {
            response    = NO;
            *stop       = YES;
        }
    }];
    
    return response;
}

- (void)discardEditing
{
    [_editors enumerateObjectsUsingBlock:^(id editor, NSUInteger idx, BOOL *stop) {
        [editor discardEditing];
    }];
}

- (BOOL)isEditing
{
    return _editors.count > 0;
}

- (void)objectDidBeginEditing:(id)editor
{
    [_editors addObject:editor];
}

- (void)objectDidEndEditing:(id)editor
{
    [_editors removeObject:editor];
}

@end
