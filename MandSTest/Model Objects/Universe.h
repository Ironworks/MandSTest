//
//  Universe.h
//  MandSTest
//
//  Created by Trevor Doodes on 12/08/2015.
//  Copyright (c) 2015 Ironworks Media Limited. All rights reserved.
//

/**
 *  This class models the universe. The universe is 2-dimensional n * n grid
 *  Assumption the  (0,0) coordinate of the univers is the bottom left corner
 */
#import <Foundation/Foundation.h>

@interface Universe : NSObject

/**
 *  Minimum X value for Universe
 */
@property (nonatomic, assign, readonly) NSUInteger minX;
/**
 *  Minimum Y value for universe
 */
@property (nonatomic, assign, readonly) NSUInteger minY;
/**
 *  Maximum X value for Universe
 */
@property (nonatomic, assign, readonly) NSUInteger maxX;
/**
 *  Maximum Y value for Universe
 */
@property (nonatomic, assign, readonly) NSUInteger maxY;


/**
 *  Initialiser for Universe
 *
 *  @param dimension Unsigned integer for number of colums and rows in Universe
 *
 *
 *  @return An instance of Universe
 */
-(instancetype)initWithDimension:(NSUInteger)dimension;

@end
