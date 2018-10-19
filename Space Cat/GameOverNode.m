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

- (void) performAnimation {
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"GameOver"];
    label.xScale = 0;
    label.yScale = 0;
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    SKAction *run = [SKAction runBlock:^{
        SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
        restart.fontSize = 24;
        restart.text = @"Touch To Restart";
        restart.position = CGPointMake(label.position.x, label.position.y-40);
        [self addChild:restart];
    }];
    
    SKAction *scaleSequence = [SKAction sequence:@[scaleUp, scaleDown, run]];
    [label runAction:scaleSequence];
}

@end
