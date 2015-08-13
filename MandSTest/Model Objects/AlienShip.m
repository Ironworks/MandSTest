//
//  AlientShip.m
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "AlienShip.h"
#import "Universe.h"

@implementation AlienShip

/**
 *  Designated init method for ALien Ship
 *
 *  @param universe The universe the ship lives in
 *
 *  @return an instance of AlienShip
 */
- (instancetype)initWithUniverse:(Universe *)universe {
    
    if (self = [super init]) {
        _universe = universe;
        _orientation = ALIEN_SHIP_ORIENTATION_UP; //Assumption: Default orientation to UP.
        _coordinates = CGPointMake(0, 0); //Assumption: The default coordinates are (0,0)
    }
    return self;
}

/**
 *  Turn ship 90 degrees to the right
 *
 *  @return YES if successful, no if not.
 */
- (BOOL) turnRight {
    
    if (self.orientation == ALIEN_SHIP_ORIENTATION_UP) {
        _orientation = ALIEN_SHIP_ORIENTATION_RIGHT;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_LEFT) {
        _orientation = ALIEN_SHIP_ORIENTATION_UP;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_RIGHT) {
        _orientation = ALIEN_SHIP_ORIENTATION_DOWN;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_DOWN) {
        _orientation = ALIEN_SHIP_ORIENTATION_LEFT;
        return YES;
    }
    
    return NO;
}

/**
 *  Turn ship 90 degress to the left
 *
 *  @return YES if successful, no if not
 */
- (BOOL) turnLeft {
    
    if (self.orientation == ALIEN_SHIP_ORIENTATION_UP) {
        _orientation = ALIEN_SHIP_ORIENTATION_LEFT;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_LEFT) {
        _orientation = ALIEN_SHIP_ORIENTATION_DOWN;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_RIGHT) {
        _orientation = ALIEN_SHIP_ORIENTATION_UP;
        return YES;
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_DOWN) {
        _orientation = ALIEN_SHIP_ORIENTATION_RIGHT;
        return YES;
    }
    
    return NO;

}

/**
 *  Move ship one space forward
 *
 *  @return YES if successful, no if not
 */
- (BOOL) moveForward {
    
    CGPoint currentPosition = self.coordinates;
    
    if (self.orientation == ALIEN_SHIP_ORIENTATION_UP) {
        currentPosition.y++;
        if ([self.universe moveToPoint:currentPosition]) {
            _coordinates = currentPosition;
            return YES;
        }
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_LEFT) {
        currentPosition.x--;
        if ([self.universe moveToPoint:currentPosition]) {
            _coordinates = currentPosition;
            return YES;
        }
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_RIGHT) {
        currentPosition.x++;
        if ([self.universe moveToPoint:currentPosition]) {
            _coordinates = currentPosition;
            return YES;
        }
    } else if (self.orientation == ALIEN_SHIP_ORIENTATION_DOWN) {
        currentPosition.y--;
        if ([self.universe moveToPoint:currentPosition]) {
            _coordinates = currentPosition;
            return YES;
        }
    }
    
    return NO;
}

/**
 *  Perform a manoeuvre on the ship
 *
 *  @param manoeuvre The manoeuvre to be performed (FORWARD, LEFT, RIGHT)
 *
 *  @return Boolean YES if the manoevre is successful, NO if it isn't
 */
- (BOOL) performManoeuvre:(NSString *)manoeuvre {
    
    if ([manoeuvre isEqualToString:@"FORWARD"]) {
        return [self moveForward];
    } else if ([manoeuvre isEqualToString:@"RIGHT"]) {
        return [self turnRight];
    } else if ([manoeuvre isEqualToString:@"LEFT"]) {
        return [self turnLeft];
    } else {
        return NO;
    }
}

@end
