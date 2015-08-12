//
//  AlientShip.h
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Universe;
@interface AlienShip : NSObject

@property (nonatomic, readonly, strong) Universe *universe;

- (instancetype)initWithUniverse:(Universe *)universe;

@end
