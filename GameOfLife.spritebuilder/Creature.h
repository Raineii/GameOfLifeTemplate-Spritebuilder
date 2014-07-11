//
//  Creature.h
//  GameOfLife
//
//  Created by Pollo on 10/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

//Stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive;

//Stores the amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;

-(instancetype)initCreature;

@end
