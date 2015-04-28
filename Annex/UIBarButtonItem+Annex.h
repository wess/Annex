//
//  UIBarButtonItem+Annex.h
//  Annex
//
//  Created by Wess Cope on 2/4/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnnexBarButtonAction)(id sender);


@interface UIBarButtonItem (Annex)
/**
 Creates a bar button item for provided systemItem with block based handler.
 
 @param systemItem  System item for bar button item,.
 @param handler     Callback used when bar button item is tapped.
 @return            Newly created bar button item.
 */
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(AnnexBarButtonAction)handler;

/**
 Creates a bar button item for provided image with block based handler.
 
 @param image       Image used by bar button item.
 @param style       UIBarButtonItemStyle.
 @param handler     Callback used when bar button item is tapped.
 @return            Newly created bar button item.
 */
- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler;

/**
 Creates a bar button item for provided title with block based handler.
 
 @param title       Title used on bar button item.
 @param style       UIBarButtonItemStyle.
 @param handler     Callback used when bar button item is tapped.
 @return            Newly created bar button item.
 */
- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler;
@end
