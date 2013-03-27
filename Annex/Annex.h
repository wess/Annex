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
#define AnnexAppVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AnnexAppBundleVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define AnnexAppExecutable      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"]
#define AnnexAppName            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define AnnexSystemName         [[UIDevice currentDevice] systemName]
#define AnnexSystemVersion      [[UIDevice currentDevice] systemVersion]
#define AnnexDeviceType         [[UIDevice currentDevice] model]

#endif
