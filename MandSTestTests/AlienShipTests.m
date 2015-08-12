//
//  AlienShipTests.m
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AlienShip.h"
#import "Universe.h"

@interface AlienShipTests : XCTestCase

@end

@implementation AlienShipTests {
    
    Universe *universe;
    AlienShip *alienShip;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    universe = [[Universe alloc] initWithDimension:10];
    alienShip = [[AlienShip alloc] initWithUniverse:universe];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    universe = nil;
    alienShip = nil;
    [super tearDown];
}

- (void) testCanCreateAlienShipInUniverse {
    
    XCTAssertNotNil(alienShip, @"Should be able to create Alien ship in universe");
    
}

- (void) testAlienShipHasUniverse {
    
    XCTAssertEqualObjects(alienShip.universe, universe, @"Alien ship should have a universe");
    
}

- (void) testAlienShipHasOrientation {
    
    XCTAssertEqual(alienShip.orientation, ALIEN_SHIP_ORIENTATION_UP, @"Alienship should have orientation");
    
}

- (void) testAlienShipHasCoordinates {
    
    CGPoint coordinates =  CGPointMake(0, 0);
    
    XCTAssertTrue(CGPointEqualToPoint(alienShip.coordinates, coordinates), @"alien ship should have coordinates");

}

- (void) testCanMoveShipForward {
    
    XCTAssertTrue([alienShip performManoeuvre:@"FORWARD"], @"alien ship should be able to move forward");
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
