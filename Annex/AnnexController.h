//
//  AnnexController.h
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

extern id AnnexNoSelectionMarker;
extern id AnnexMultipleValueMarker;
extern id AnnexNotApplicableMarker;

@interface AnnexController : NSObject<NSCoding>
- (BOOL)commitEditing;
- (void)discardEditing;
- (BOOL)isEditing;
- (void)objectDidBeginEditing:(id)editor;
- (void)objectDidEndEditing:(id)editor;
@end
