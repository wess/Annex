//
//  AnnexDefines.h
//  Annex
//
//  Created by Wess Cope on 3/26/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#ifndef _ANNEX_DEFINES_H
#define _ANNEX_DEFINES_H

// Shortcuts
#define AnnexAppVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AnnexAppBundleVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define AnnexAppExecutable      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"]
#define AnnexAppName            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define AnnexSystemName         [[UIDevice currentDevice] systemName]
#define AnnexSystemVersion      [[UIDevice currentDevice] systemVersion]
#define AnnexDeviceType         [[UIDevice currentDevice] model]

#define ANNEX_IS_IPAD       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ANNEX_IS_IPHONE_5   (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568 ) < DBL_EPSILON)

#define ANNEX_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ANNEX_SUPPRESS_DEPRECIATED_DECLARATIONS(code) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang \"-Wdeprecated-declarations\""); \
code; \
_Pragma("clang diagnostic pop"); \
} while(0);

#define ANNEX_SUPRESS_DEPRECIATION \
_Pragma("clang diagnostic push") \
_Pragma("clang \"-Wdeprecated-declarations\"")

#define ANNEX_SUPRESS_DEPRECIATION_END \
_Pragma("clang diagnostic pop")

#ifndef weakify
#define weakify(context) try {} @finally {} \
__weak typeof(context) nf_weak_ ## context = context
#endif

#ifndef strongify
#define strongify(o) try {} @finally {} \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
typeof(nf_weak_ ## o) o = nf_weak_ ## o \
_Pragma("clang diagnostic pop")
#endif


#endif
