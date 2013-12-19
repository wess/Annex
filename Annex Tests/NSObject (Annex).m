//
//  NSObject (Annex).m
//  Annex
//
//  Created by Juan Alvarez on 12/12/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSObject+Annex.h"

// Macro - Set the flag for block completion
#define StartBlock() __block BOOL waitingForBlock = YES

// Macro - Set the flag to stop the loop
#define EndBlock() waitingForBlock = NO

// Macro - Wait and loop until flag is set
#define WaitUntilBlockCompletes() WaitWhile(waitingForBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
// Each test should have its own instance of a BOOL condition because of non-thread safe operations
#define WaitWhile(condition) \
do { \
while(condition) { \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
} \
} while(0)

@interface NSObjectCategory : XCTestCase

@end

@implementation NSObjectCategory

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExecuteBlockInBackgroundWithWeakReferenceWithCallBack
{
	StartBlock();
	
    [self executeBlockInBackgroundWithWeakReference:^(__weak id this) {
		XCTAssertFalse([NSThread isMainThread], @"This block should not be on the main thread");
		
	} withCallback:^(__weak id this) {
		EndBlock();
		
		XCTAssertTrue([NSThread isMainThread], @"This block should be on the main thread");
	}];
	
	WaitUntilBlockCompletes();
}

- (void)testExecuteBlockInBackgroundWithCallBack
{
	StartBlock();
	
	[NSObject executeBlockInBackground:^{
		XCTAssertFalse([NSThread isMainThread], @"This block should not be on the main thread");
	} withCallback:^{
		EndBlock();
		
		XCTAssertTrue([NSThread isMainThread], @"This block should be on the main thread");
	}];
	
	WaitUntilBlockCompletes();
}

- (void)testExecuteBlockInBackgroundWithWeakReferenceAfterDelay
{
	StartBlock();
	
	NSTimeInterval delay = 2.0;
	
	NSDate *currentDate = [NSDate date];
	
	[self executeBlockInBackgroundWithWeakReference:^(__weak id this) {
		EndBlock();
		
		double seconds = round([[NSDate date] timeIntervalSinceDate: currentDate]);
		
		XCTAssertTrue(seconds == delay, @"This block should be executed in about 2 seconds");
		
		XCTAssertFalse([NSThread isMainThread], @"This block should not be on the main thread");
	} afterDelay: delay];
	
	WaitUntilBlockCompletes();
}

- (void)testExecuteBlockInBackgroundAfterDelay
{
	StartBlock();
	
	NSTimeInterval delay = 2.0;
	
	NSDate *currentDate = [NSDate date];
	
	[NSObject executeBlockInBackground:^{
		EndBlock();
		
		double seconds = round([[NSDate date] timeIntervalSinceDate: currentDate]);
		
		XCTAssertTrue(seconds == delay, @"This block should be executed in about 2 seconds");
		
		XCTAssertFalse([NSThread isMainThread], @"This block should not be on the main thread");
	} afterDelay: delay];
	
	WaitUntilBlockCompletes();
}

- (void)testExecuteBlockOnMainThreadWithWeakReference
{
	[self executeBlockOnMainThreadWithWeakReference:^(__weak id this) {
		XCTAssertTrue([NSThread isMainThread], @"This block should not be on the main thread");
	}];
}

- (void)testExecuteBlockOnMainThread
{
	[NSObject executeBlockOnMainThread:^{
		XCTAssertTrue([NSThread isMainThread], @"This block should not be on the main thread");
	}];
}

- (void)testExecuteBlockOnMainThreadWithWeakReferenceAfterDelay
{
	StartBlock();
	
	NSTimeInterval delay = 2.0;
	
	NSDate *currentDate = [NSDate date];
	
	[self executeBlockOnMainThreadWithWeakReference:^(__weak id this) {
		EndBlock();
		
		double seconds = round([[NSDate date] timeIntervalSinceDate: currentDate]);
		
		XCTAssertTrue(seconds == delay, @"This block should be executed in about 2 seconds");
		
		XCTAssertTrue([NSThread isMainThread], @"This block should not be on the main thread");
	} afterDelay: delay];
	
	WaitUntilBlockCompletes();
}

- (void)testExecuteBlockOnMainThreadAfterDelay
{
	StartBlock();
	
	NSTimeInterval delay = 2.0;
	
	NSDate *currentDate = [NSDate date];
	
	[NSObject executeBlockOnMainThread:^{
		EndBlock();
		
		double seconds = round([[NSDate date] timeIntervalSinceDate: currentDate]);
		
		XCTAssertTrue(seconds == delay, @"This block should be executed in about 2 seconds");
		
		XCTAssertTrue([NSThread isMainThread], @"This block should not be on the main thread");
	} afterDelay: delay];
	
	WaitUntilBlockCompletes();
}

@end
