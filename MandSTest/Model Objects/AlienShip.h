//
//  AlientShip.h
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Universe;

typedef NS_ENUM(NSUInteger, ALIEN_SHIP_ORIENTATION) {
    
    ALIEN_SHIP_ORIENTATION_UP,
    ALIEN_SHIP_ORIENTATION_DOWN,
    ALIEN_SHIP_ORIENTATION_LEFT,
    ALIEN_SHIP_ORIENTATION_RIGHT
    
};

@interface AlienShip : NSObject

/**
 *  The universe that the alien ship lives in.
 */
@property (nonatomic, readonly, strong) Universe *universe;
/**
 *  Orientation of the ship relative to the universe
 */
@property (nonatomic, readonly, assign) ALIEN_SHIP_ORIENTATION orientation;

- (instancetype)initWithUniverse:(Universe *)universe;

@end
