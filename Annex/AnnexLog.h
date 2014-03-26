//
//  AnnexLog.h
//  Annex
//
//  Created by Wess Cope on 3/26/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#ifndef _ANNEX_LOG_H
#define _ANNEX_LOG_H

#ifdef DEBUG
#define ALog(fmt, ...) ({ NSLog(@"-- [%s:%d] %s: " fmt, __FILE__, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__); })
#else
#define ALog(fmt, ...)
#endif


#endif
