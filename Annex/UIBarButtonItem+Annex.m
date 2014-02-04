//
//  UIBarButtonItem+Annex.m
//  Annex
//
//  Created by Wess Cope on 2/4/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UIBarButtonItem+Annex.h"
#import <objc/runtime.h>

@interface UIBarButtonItem(AnnexPrivate)
- (void)annexButtonAction:(id)sender;
@end

@implementation UIBarButtonItem (Annex)
static const char *AnnexUIBarButtonItemHandlerKey;

#define AnnexUIBarButtonItemSetHandler      objc_setAssociatedObject(self, AnnexUIBarButtonItemHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC)

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(AnnexBarButtonAction)handler
{
    self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(annexButtonAction:)];
    AnnexUIBarButtonItemSetHandler;
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler
{
    self = [self initWithImage:image style:style target:self action:@selector(annexButtonAction:)];
    AnnexUIBarButtonItemSetHandler;
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler
{
    self = [self initWithTitle:title style:style target:self action:@selector(annexButtonAction:)];
    AnnexUIBarButtonItemSetHandler;
    
    return self;
}

- (void)annexButtonAction:(id)sender
{
    AnnexBarButtonAction action = objc_getAssociatedObject(self, AnnexUIBarButtonItemHandlerKey);
    if(action)
        action(self);
}

@end
