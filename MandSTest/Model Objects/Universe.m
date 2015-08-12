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

@end
