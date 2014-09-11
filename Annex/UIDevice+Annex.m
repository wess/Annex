//
//  UIDevice+Annex.m
//  Annex
//
//  Created by Wess Cope on 4/16/14.
//  Copyright (c) 2014 Wess Cope. All rights reserved.
//

#import "UIDevice+Annex.h"

@implementation UIDevice (Annex)
+ (BOOL) jailBroken
{
#if !TARGET_IPHONE_SIMULATOR
	BOOL yes;
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.", @"app"]]
		|| [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&yes]
		||  [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia"] isDirectory:&yes])
	{
		//Cydia installed
		return YES;
	}
    
	//Try to write file in private
	NSError *error;
    
	static NSString *str = @"Jailbreak test string";
    
	[str writeToFile:@"/private/test_jail.txt" atomically:YES
			encoding:NSUTF8StringEncoding error:&error];
    
	if(error==nil)
		return YES;
    else
		[[NSFileManager defaultManager] removeItemAtPath:@"/private/test_jail.txt" error:nil];
    
#endif
	return NO;
}
@end
