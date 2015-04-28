//
//  UIButton+Annex.m
//  Annex
//
//  Created by Wess Cope on 3/7/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "UIButton+Annex.h"
#import <objc/runtime.h>
#import "AnnexDefines.h"

@interface ANNEX_HANDLER_PROXY : NSObject
@property (strong, nonatomic) NSArray   *handlers;
@property (strong, nonatomic) UIButton  *button;

- (instancetype)initWithButton:(UIButton *)button;
- (void)addHandler:(AnnexActionHandler)handler;
- (void)executeHandlers;
@end

@implementation ANNEX_HANDLER_PROXY
- (instancetype)initWithButton:(UIButton *)button
{
    self = [super init];
    if(self)
        self.button = button;

    return self;
}

- (void)addHandler:(AnnexActionHandler)handler
{
    NSMutableArray *handlers = [(self.handlers?: @[]) mutableCopy];

    [handlers addObject:handler];

    self.handlers = [handlers copy];
    
    [self.button addTarget:self action:@selector(executeHandlers) forControlEvents:UIControlEventTouchUpInside];
}

- (void)executeHandlers
{
    UIButton *button = self.button;
    
    @weakify(button);
    [self.handlers enumerateObjectsUsingBlock:^(AnnexActionHandler handler, NSUInteger idx, BOOL *stop) {
        @strongify(button);
        
        handler(button);
    }];
}

@end

@implementation UIButton (Annex)
static const void *ANNEX_BUTTON_BACKGROUNDS_KEY = &ANNEX_BUTTON_BACKGROUNDS_KEY;
static const void *ANNEX_ACTION_HANDLER_KEY     = &ANNEX_ACTION_HANDLER_KEY;

@dynamic backgroundColors;
@dynamic placeholderImage;

static void AddHandlerToProxy(UIButton *this, AnnexActionHandler handler) {
    static ANNEX_HANDLER_PROXY *proxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxy = [[ANNEX_HANDLER_PROXY alloc] initWithButton:this];
    });
    
    [proxy addHandler:handler];
}

- (void)setBackgroundColors:(NSMutableDictionary *)backgroundColors
{
    objc_setAssociatedObject(self, ANNEX_BUTTON_BACKGROUNDS_KEY, backgroundColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)backgroundColors
{
    return (NSMutableDictionary *)objc_getAssociatedObject(self, ANNEX_BUTTON_BACKGROUNDS_KEY);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if([self backgroundColors] == NULL)
        [self setBackgroundColors:[NSMutableDictionary new]];
    
    [[self backgroundColors] setObject:backgroundColor forKey:@(state)];
}

#pragma mark - Handle Background color toggle -
- (void)animateBackgroundToColor:(NSNumber *)key
{
    UIColor *backgroundColor = [[self backgroundColors] objectForKey:key];
    if(backgroundColor)
    {
        [UIView animateWithDuration:0.1f animations:^{
            self.backgroundColor = backgroundColor;
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateHighlighted]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

- (void)addActionHandler:(AnnexActionHandler)handler
{
    AddHandlerToProxy(self, handler);
}

@end
