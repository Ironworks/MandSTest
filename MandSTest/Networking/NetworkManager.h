//
//  NetworkManager.h
//  MandSTest
//
//  Created by Trevor Doodes on 13/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

/**
 *  Directions successfully retrieved block
 *
 *  @param directionsArray Array of directions
 */
typedef void (^getDirectionsSuccess) (NSArray *directionsArray);


/**
 *  API request failed
 *
 *  @param message    Human redable message
 *  @param statusCode int error code
 */
typedef void (^requestFailed) (NSString *message, NSInteger statusCode);


/**
 *  Get the probe navigation data
 *
 *  @param email   valid email address
 *  @param success block to be performed on successful execution
 *  @param failure block to be performed on unsuccessful execution
 */
- (void) probeNavigationGetDataForEmail:(NSString *) email
                         requestSuccess:(getDirectionsSuccess)success
                         requestFailure:(requestFailed)failure;


@end
