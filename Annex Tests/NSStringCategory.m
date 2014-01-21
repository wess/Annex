//
//  NSStringCategory.m
//  Annex
//
//  Created by Juan Alvarez on 12/12/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+Annex.h"

@interface NSStringCategory : XCTestCase

@end

@implementation NSStringCategory

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

- (void)testStringIsNotEqualToString
{
	XCTAssertTrue([@"Word" isNotEqualToString:@"Yo Mama"], @"Should return true if strings are not equal.");
	XCTAssertFalse([@"Word" isNotEqualToString:@"Word"], @"Should return false if strings are equal.");
}

- (void)testIsEqualToStringCaseInsensitive
{
	XCTAssertTrue([@"WORD" isEqualToStringCaseInsensitive:@"word"], @"Should return true if strings is not equal using case insensitive option.");
	XCTAssertTrue([@"word" isEqualToStringCaseInsensitive:@"word"], @"Should still return true if strings are exactly the same.");
	XCTAssertFalse([@"word" isEqualToStringCaseInsensitive:@"asdf"], @"Should return NO if strings are not equal.");
}

- (void)testIsEqualToStringDiacriticallyInsensitive
{
	XCTAssertTrue([@"niña" isEqualToStringDiacriticallyInsensitive:@"nina"], @"Should return true if strings are diacritically insensitive equal.");
	XCTAssertTrue([@"asdf" isEqualToStringDiacriticallyInsensitive:@"asdf"], @"Should still return true if strings are exactly the same");
	XCTAssertFalse([@"word" isEqualToStringCaseInsensitive:@"asdf"], @"Should return NO if strings are not equal.");
}

- (void)testUUIDMethods
{
	NSString *UUIDString = [NSString UUIDString];
	NSUUID *UUIDObject = [UUIDString UUIDRepresentation];
	
	XCTAssertNotNil(UUIDString, @"This must return a string. Not nil.");
	XCTAssertNotNil(UUIDObject, @"This must return an NSUUID object");
	
	XCTAssertEqualObjects(UUIDString, UUIDObject.UUIDString, @"The original UUID string and the derived UUID object's string representation should be equal.");
	
	NSUUID *invalidUUID = [@"lkjahsdf" UUIDRepresentation];
	
	XCTAssertNil(invalidUUID, @"This should not return a vaild NSUUID object");
}

@end
