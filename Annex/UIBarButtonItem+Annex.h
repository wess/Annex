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
- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(AnnexBarButtonAction)handler;
- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler;
- (instancetype)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(AnnexBarButtonAction)handler;
@end
