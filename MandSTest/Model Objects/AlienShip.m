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

- (instancetype)initWithUniverse:(Universe *)universe {
    
    if (self = [super init]) {
        _universe = universe;
    }
    return self;
}

@end
