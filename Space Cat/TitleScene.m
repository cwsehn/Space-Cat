//
//  TitleScene.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/14/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "TitleScene.h"
#import "GamePlayScene.h"



@interface TitleScene ()

@property (nonatomic) SKAction *pressStartSFX;

@end

@implementation TitleScene

- (void)sceneDidLoad {
    // Setup your scene here    

    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self runAction:self.pressStartSFX];
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
