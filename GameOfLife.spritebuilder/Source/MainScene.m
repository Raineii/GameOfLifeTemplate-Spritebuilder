//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

/*@interface MainScene ()

@property(nonatomic, strong) Grid *grid;
@property(nonatomic, strong) CCTimer *timer;
@property(nonatomic, strong) CCLabelTTF *generationLabel;
@property(nonatomic, strong) CCLabelTTF *populationLabel;

@end*/

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
    
}

-(instancetype) init{
    
    self = [super init];
    
    if(self){
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
}

-(void) play{
    //this tells the game to call a method called "step" every half of a second
    [self schedule:@selector(step) interval:0.5f];
}

-(void) pause{
    [self unschedule:@selector(step)];
}

//this method will get called every half of a second when you hit 'play' and will stop each time you hit 'pause'
-(void) step{
    
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
}


@end
