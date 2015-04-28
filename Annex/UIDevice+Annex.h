//
//  UIDevice+Annex.h
//  Annex
//
//  Created by Wess Cope on 4/16/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Annex)
/**
 A quick test to see if a device is jail broken or not.

 @return Boolean value to indicate jail break status.
 */
+ (BOOL) jailBroken;
@end
