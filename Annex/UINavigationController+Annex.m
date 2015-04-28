//
//  UINavigationController+Annex.m
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import "UINavigationController+Annex.h"

@implementation UINavigationController (Annex)
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:nil context:NULL];
    
    [self pushViewController:controller animated:NO];
    
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    
    [UIView commitAnimations];
}

- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition
{
    [UIView beginAnimations:nil context:NULL];
    
    UIViewController *controller = [self popViewControllerAnimated:NO];
    
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    
    [UIView commitAnimations];
    
    return controller;
}

@end
