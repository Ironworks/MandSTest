//
//  AlientShip.h
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

@import CoreGraphics;
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

/**
 *  Curent coordinates of the ship within its universe.
 */
@property (nonatomic, readonly, assign) CGPoint coordinates;


/**
 *  Designated init method for ALien Ship
 *
 *  @param universe The universe the ship lives in
 *
 *  @return an instance of AlienShip
 */
- (instancetype)initWithUniverse:(Universe *)universe;

/**
 *  Perform a manoeuvre on the ship
 *
 *  @param manoeuvre The manoeuvre to be performed (FORWARD, LEFT, RIGHT)
 *
 *  @return Boolean YES if the manoevre is successful, NO if it isn't
 */
-(BOOL) performManoeuvre:(NSString *)manoeuvre;

@end
