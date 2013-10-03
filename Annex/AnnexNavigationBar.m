//
//  AnnexNavigationBar.m
//  Annex
//
//  Created by Wess Cope on 10/3/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexNavigationBar.h"

@interface AnnexNavigationBar()
@property (readonly, nonatomic) CGFloat statusBarHeight;
@property (readonly, nonatomic) CALayer *colorLayer;

- (void)setup;
@end

@implementation AnnexNavigationBar
@synthesize colorLayer      = _colorLayer;

static CGFloat const DefaultLayerOpacity    = 0.5f;

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsLayout) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
        [self setup];

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
        [self setup];

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGFloat)statusBarHeight
{
    CGRect statusBarFrame = [self.window convertRect:UIApplication.sharedApplication.statusBarFrame toView:self];
    
    return statusBarFrame.size.height;
}

- (CALayer *)colorLayer
{
    if(_colorLayer)
        return _colorLayer;
    
    _colorLayer         = [CALayer layer];
    _colorLayer.opacity = DefaultLayerOpacity;
    
    [self.layer addSublayer:_colorLayer];
    
    return _colorLayer;
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
    
    self.colorLayer.backgroundColor = barTintColor.CGColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.colorLayer.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, (self.bounds.size.height + self.statusBarHeight));
    [self.layer insertSublayer:self.colorLayer atIndex:1];
}


@end
