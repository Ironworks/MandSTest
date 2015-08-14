//
//  NetworkManagerTests.m
//  MandSTest
//
//  Created by Trevor Doodes on 13/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NetworkManager.h"
#import <OCMock/OCMock.h>



@interface NetworkManagerTests : XCTestCase

@end

@implementation NetworkManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSArray *) stubResults {
    
    NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:@"Directions" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSError *error = nil;
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    NSArray *directions = [json objectForKey:@"Directions"];
    
    return directions;
    
}



- (void) testCanCreateNetworkManager {
    
    NetworkManager *networkManager = [[NetworkManager alloc] init];
    XCTAssertNotNil(networkManager, @"Should be able to create network manager");
    
}

- (void) testProbeNavigationGetDataSuccess {
    
    id mock = [OCMockObject mockForClass:[NetworkManager class]];
    
    [[[mock stub] andDo:^(NSInvocation *invocation) {
        //our stubbed results
        NSArray *directions = [self stubResults];
        
        getDirectionsSuccess blockToExecute = nil;
        
        
        [invocation getArgument:&blockToExecute atIndex:3];
        
        blockToExecute(directions);
        
    }] probeNavigationGetDataForEmail:[OCMArg any]
     requestSuccess:[OCMArg any]
     requestFailure:[OCMArg any]];
    
    
    [mock probeNavigationGetDataForEmail:[OCMArg any]
                          requestSuccess:^(NSArray *directionsArray) {
                              
                              XCTAssertTrue((directionsArray.count == 41), @"Array should have data");
                              
                          } requestFailure:^(NSString *message, NSInteger statusCode) {
                              
                              //Should not see this in our test
                              
                              XCTAssertTrue(NO, @"Should not have an error");
                                            
                          }];
    
}


- (void) testProbeNavigationGetDataFailure {
    
    id mock = [OCMockObject mockForClass:[NetworkManager class]];
    
    [[[mock stub] andDo:^(NSInvocation *invocation) {
        //Our stubbed results
        NSUInteger statusCode = 500;
        NSString *message = @"Error, something went wrong";
        
        //Block to execute
        requestFailed blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:4];
        
        blockToExecute(message, statusCode);
        
    }] probeNavigationGetDataForEmail:[OCMArg any]
     requestSuccess:[OCMArg any]
     requestFailure:[OCMArg any]];
    
    
    [mock probeNavigationGetDataForEmail:[OCMArg any]
                          requestSuccess:^(NSArray *directionsArray) {
                              //We should not see this in our test
                              XCTAssertTrue(NO, @"Should not see this");
                          } requestFailure:^(NSString *message, NSInteger statusCode) {
                              XCTAssertEqualObjects(message, @"Error, something went wrong", @"Error message should be set");
                              XCTAssertEqual(statusCode, 500, @"Status code should be set to 500");
                          }];
    
    
}


- (void) testProbenavigationSubmitDataSuccess {
    
    id mock = [OCMockObject mockForClass:[NetworkManager class]];
    
    [[[mock stub] andDo:^(NSInvocation *invocation) {
        //Stubbed results
        NSUInteger statusCode = 200;
        NSString *message = @"Probe launched to the correct coordinates";
        
        //Block to execute
        submitDataSuccess blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:4];
        
        blockToExecute(message, statusCode);
        
        
    }] probeNavigationSubmitDataForEmail:[OCMArg any]
     coordinates: CGPointZero
     requestSuccess:[OCMArg any]
     requestFailure:[OCMArg any]];
    
    
    [mock probeNavigationSubmitDataForEmail:[OCMArg any]
                                coordinates:CGPointZero
                             requestSuccess:^(NSString *message, NSInteger statusCode) {
                                 XCTAssertEqualObjects(message, @"Probe launched to the correct coordinates");
                                 XCTAssertEqual(statusCode, 200, @"Status code should be set to 200");
                             } requestFailure:^(NSString *message, NSInteger statusCode) {
                                 //We should not see this in our test
                                 XCTAssertTrue(NO, @"Should not see this");
                             }];
}


- (void) testProbenavigationSubmitDataFailure {
    
    id mock = [OCMockObject mockForClass:[NetworkManager class]];
    
    [[[mock stub] andDo:^(NSInvocation *invocation) {
        //Stubbed results
        NSUInteger statusCode = 500;
        NSString *message = @"Probe sent to wrong location";
        
        //Block to execute
        requestFailed blockToExecute = nil;
        
        [invocation getArgument:&blockToExecute atIndex:5];
        
        blockToExecute(message, statusCode);
        
        
    }] probeNavigationSubmitDataForEmail:[OCMArg any]
     coordinates: CGPointZero
     requestSuccess:[OCMArg any]
     requestFailure:[OCMArg any]];
    
    
    [mock probeNavigationSubmitDataForEmail:[OCMArg any]
                                coordinates:CGPointZero
                             requestSuccess:^(NSString *message, NSInteger statusCode) {
                                 //We should not see this in our test
                                 XCTAssertTrue(NO, @"Should not see this");
                             } requestFailure:^(NSString *message, NSInteger statusCode) {
                                 XCTAssertEqualObjects(message, @"Probe sent to wrong location");
                                 XCTAssertEqual(statusCode, 500, @"Status code should be set to 500");
                             }];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
