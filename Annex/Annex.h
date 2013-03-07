//
//  Annex.h
//  Annex
//
//  Created by Wess Cope on 2/20/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//


#ifndef __ANNEX_H__
#define __ANNEX_H__

#import "NSObject+Annex.h"
#import "NSDate+Annex.h"
#import "NSString+Annex.h"
#import "NSDictionary+Annex.h"
#import "UIColor+Annex.h"
#import "UIView+Annex.h"
#import "UIButton+Annex.h"
#import "UITextView+Annex.h"

// Shortcuts
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUNDLE_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_EXECUTABLE      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"]
#define APP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define SYSTEM_NAME         [[UIDevice currentDevice] systemName]
#define SYSTEM_VERSION      [[UIDevice currentDevice] systemVersion]
#define DEVICE_TYPE         [[UIDevice currentDevice] model]

#endif
