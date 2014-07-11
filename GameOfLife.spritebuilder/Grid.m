//
//  Grid.m
//  GameOfLife
//
//  Created by Pollo on 10/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

/*@interface Grid ()

@property (nonatomic, strong) NSMutableArray *gridArray; //ofCreatures
@property (nonatomic, assign) float cellWidth;
@property (nonatomic, assign) float cellHeight;


@end*/

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid{
    
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
    
}


-(void)onEnter{
    [super onEnter];
    [self setupGrid];
    
    //Accept touches on the grid
    self.userInteractionEnabled = YES;
}

-(void)setupGrid{
    //Divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    //Initialize the array as a blank NSMutableArray
    _gridArray = [NSMutableArray array];
    
    //Initialize Creatures
    for(int i = 0; i < GRID_ROWS; i++){
        //This is how you create 2D Arrays in Obj-c. You put arrays into arrays.
        _gridArray[i] = [NSMutableArray array];
        
        x = 0;
        
        
        for(int j = 0; j < GRID_COLUMNS; j++){
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            //Shorthand to acces an array inside an array
            _gridArray[i][j] = creature;
            
            //Make creatures visible to test this method. Remove once we know we've filled the grid properly.
            
            //creature.isAlive = YES;
            
            x += _cellWidth; //Increase 'x' after each cell
            
        }
        y += _cellHeight; //Increase 'y' after each row
    }
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    //Get the (x,y) coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //Get the Creature at that location
    Creature *creature = [self creatureForTouchPosition: touchLocation];
    
    //Invert it's state - kill it if it's alive or bring it to life if it's dead
    creature.isAlive = !creature.isAlive;
}


-(Creature *)creatureForTouchPosition:(CGPoint)touchPosition{
    //Get the row and column that was touched and get the creature in that cell
    int column = touchPosition.x / _cellWidth;
    int row = touchPosition.y / _cellHeight;
    
    return _gridArray[row][column];
}

-(void)evolveStep{
    //Update each Creature's neighbor count
    [self countNeighbors];
    
    //Update each Creature's state
    [self updateCreatures];
    
    //Update the generation for the label text to display the correct generation
    self.generation++;
}

-(void)countNeighbors{
    //Iterate through the rows
    //Note that NSArray has a 'count' method that will return the number of elements in the array
    for(int i = 0; i < [_gridArray count]; i++){
        
        //iterate through all the columns for a given row
        for(int j = 0; j < [_gridArray[i] count]; j++){
            //Access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            //Remember that every creature has a 'livingNeighbors' property
            currentCreature.livingNeighbors = 0;
            
            //Now examine every cell around the current one
            
            //Go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for(int x = (i - 1); x <= (i + 1); x++){
                //Go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for(int y = (j - 1); y <= (j + 1); y++){
                    //check that the cell we're at is not off the screen
                    BOOL isIndexValid = [self isIndexValidForX: x andY: y];
                    
                    //Skip over all cells that are off screen AND the cell that contains the creature we're currently updating
                    if(!((x == i) && (y == j)) && isIndexValid){
                        
                        Creature *neighbor = _gridArray[x][y];
                        if(neighbor.isAlive){
                            currentCreature.livingNeighbors += 1;
                        }
                        
                    }
                    
                }
            }
            
            
        }
    }
}

-(void)updateCreatures{
    
    int numAlive = 0;
    
    for(int i = 0; i < [_gridArray count]; i++){
        
        for(int j = 0; j < [_gridArray[i] count]; j++){
            Creature *creature = _gridArray[i][j];
            
            if(creature.livingNeighbors == 3){
                creature.isAlive = YES;
                numAlive++;
            }
            else{
                if(creature.livingNeighbors <= 1 || creature.livingNeighbors >= 4){
                    creature.isAlive = NO;
                }
            }
        }
    }
    
    self.totalAlive = numAlive;
    
}

-(BOOL)isIndexValidForX: (int)x andY: (int)y{
    
    BOOL isIndexValid = YES;
    
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS){
        isIndexValid = NO;
    }
    
    return isIndexValid;
}


@end
