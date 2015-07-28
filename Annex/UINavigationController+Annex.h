//
//  UINavigationController+Annex.h
//  Annex
//
//  Created by Wesley Cope on 4/28/15.
//  Copyright (c) 2015 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Annex)
/**
 Pushes ViewController on to navigation stack using custom, provided, transition.
 
 @param controller  Controller to push on to the nav controllers stack.
 @param transition  Transition used to animation the controller's presentation.
 */
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;

/**
 Pops the top view controller using custom, provided, transition.
 
 @param transition  Transition used to animation the controller being dismissed.
 @return            Controller popped of nav stack.
 */
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;
@end
