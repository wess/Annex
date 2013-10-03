//
//  AnnexNavigationController.m
//  Annex
//
//  Created by Wess Cope on 10/3/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "AnnexNavigationController.h"
#import "AnnexNavigationBar.h"

@interface AnnexNavigationController ()
@end

@implementation AnnexNavigationController

- (id)init
{
    self = [super initWithNavigationBarClass:[AnnexNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:[AnnexNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self)
    {
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

@end
