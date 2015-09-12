//
//  test_prepare_for_segue_between_swift_and_objectiveTests.m
//  test prepare for segue between swift and objectiveTests
//
//  Created by Will Ge on 9/5/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface test_prepare_for_segue_between_swift_and_objectiveTests : XCTestCase

@end

@implementation test_prepare_for_segue_between_swift_and_objectiveTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
