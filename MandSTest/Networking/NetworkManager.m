//
//  NetworkManager.m
//  MandSTest
//
//  Created by Trevor Doodes on 13/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "NetworkManager.h"

NSString * const kBaseURL = @"https://mands-alien-test.herokuapp.com/api/spaceprobe/";


typedef NS_ENUM(NSUInteger, HTTPStatusCode) {
    HTTPStatusCodeOK = 200,
    HTTPStatusCodePostOK = 201,
    HTTPStatusCodeBadRequest   = 400,
    HTTPStatusCodeUnauthorised = 401,
    HTTPStatusCodeForbidden    = 403,
    HTTPStatusCodeNotFound     = 404,
    HTTPStatusCodeInternalError = 500
};



@implementation NetworkManager


/**
 *  Create user session
 *
 *  @return NSURLSession
 */
- (NSURLSession *)session
{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfig setHTTPAdditionalHeaders:@{@"Content-Type" : @"application/json",
                                              @"Accept" : @"application/json"}];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    return session;
}

/**
 *  Setup mutable GET request for urlString
 *
 *  @param urlString String representation of the rquested URL
 *
 *  @return mutable GET request
 */
- (NSMutableURLRequest *)mutableRequestForURLString:(NSString *)urlString
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:urlString]];
    return request;
}



/**
 *  Get the probe navigation data
 *
 *  @param email   valid email address
 *  @param success block to be performed on successful execution
 *  @param failure block to be performed on unsuccessful execution
 */
- (void) probeNavigationGetDataForEmail:(NSString *) email
                         requestSuccess:(getDirectionsSuccess)success
                         requestFailure:(requestFailed)failure {
    
    
    NSParameterAssert(email);
    
    //Create session
    NSURLSession *session = [self session];
    
    NSString *urlString = [NSString stringWithFormat:@"%@getdata/%@", kBaseURL, email];
    
    NSMutableURLRequest *request = [self mutableRequestForURLString:urlString];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    NSError *jsonError;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&jsonError];
                    //Check status code for request
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                    if (httpResp.statusCode == HTTPStatusCodeOK) {
                        
                        if (json[@"Directions"]) {
                            NSArray *directions = json[@"Directions"];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (success) {
                                    success(directions);
                                }
                            });
                            
                        }
                        
                    } else if (httpResp.statusCode == HTTPStatusCodeInternalError) {
                        
                        if (json[@"Message"]) {
                            NSString *message = json[@"Message"];
                            NSNumber *statusCode = json[@"StatusCode"];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (failure) {
                                    failure(message, [statusCode integerValue]);
                                }
                            });

                        }
                        
                    } else {
                        
                        //Something else has gone wrong
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (failure) {
                                failure(@"Unknown error occured", 999);
                                
                            }
                        });
                    }
                    
                }] resume];
    
    
    
}

@end
