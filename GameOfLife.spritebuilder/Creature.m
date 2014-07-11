//
//  Creature.m
//  GameOfLife
//
//  Created by Pollo on 10/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(instancetype)initCreature{
    //Since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if(self){
        self.isAlive = NO;
    }
    
    return self;
}

-(void)setIsAlive:(BOOL)isAlive{
    //When you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _isAlive = isAlive;
    
    //'visible' is a property of any class that inherits from CCNode. CCSprite is a subclass of CCNode, and Creature is a subclass of CCSprite, so Creatures have a visible property
    self.visible = _isAlive;
}

@end
