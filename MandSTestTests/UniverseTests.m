//
//  UniverseTests.m
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Universe.h"

@interface UniverseTests : XCTestCase

@end

@implementation UniverseTests {
    
    Universe *myUniverse;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    myUniverse = [[Universe alloc] initWithDimension:10];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    myUniverse = nil;
    [super tearDown];
}

- (void)testCanCreateuniverseWithDimension {
    
    XCTAssertNotNil(myUniverse, @"Should be able to create a Universe intance with dimension");
    
}

- (void)testUniverseHasAMinXValue {
    
    XCTAssertEqual(myUniverse.minX, 0, @"MinX must be a numeric value");
    
}

- (void)testUniverseHasAMinYValue {
    
    XCTAssertEqual(myUniverse.minY, 0, @"MinY must be a nemeric value");
                   
}

- (void)testUniverseHasMaxXValue {
    
    XCTAssertEqual(myUniverse.maxX, 10, @"MaxX must be a numeric value");
    
}

- (void)testUniverseHasAMaxYValue {
    
    XCTAssertEqual(myUniverse.maxY, 10, @"MaxY must be a numeric value");
    
}

- (void) testUniverseWithZeroDimensionReturnsNil {
    
    Universe *zeroUniverse = [[Universe alloc] initWithDimension:0];
    XCTAssertNil(zeroUniverse, @"Should not be able to create a zero dimension universe");
    
}

- (void) testSpaceObjectCanMakeValidMove {
    
    CGPoint pointToMvoeTo = CGPointMake(5, 5);
    XCTAssertTrue([myUniverse moveToPoint], @"Valid move should return true");
    
}




@end
