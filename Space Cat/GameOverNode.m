//
//  GameOverNode.m
//  Space Cat
//
//  Created by Chris William Sehnert on 10/18/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "GameOverNode.h"

@implementation GameOverNode

+ (instancetype) gameOverAtPosition:(CGPoint)position {
    GameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    
    [gameOver addChild:gameOverLabel];
    return gameOver;
}

@end
