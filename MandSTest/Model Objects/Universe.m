//
//  Universe.m
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

#import "Universe.h"

@implementation Universe



/**
 *  Initialiser for Universe
 *
 *  @param dimension Unsigned integer for number of colums and rows in Universe
 *
 *
 *  @return An instance of Universe
 */
-(instancetype)initWithDimension:(NSUInteger)dimension {
    
    if (dimension == 0) {
        return nil;
    }
    
    
    if (self = [super init]) {
        _minX = 0;
        _minY = 0;
        _maxX = dimension;
        _maxY = dimension;
    }
    
    return self;
    
}

/**
 *  Check to see if move is legal
 *
 *  @param point point to move to
 *
 *  @return YES if leagal move, otherwise NO
 */

- (BOOL) moveToPoint:(CGPoint)point {
    
    if (point.x >= self.minX && point.x <= self.maxX &&
        point.y >= self. minY && point.y <= self.maxY) {
        
        return YES;
        
    } else {
        
        return NO;
    }
    
    
}

@end
