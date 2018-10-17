//
//  SpaceDogNode.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/23/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "SpaceDogNode.h"
#import "Util.h"

@implementation SpaceDogNode

+ (instancetype) spaceDogOfType: (SpaceDogType)type {
    SpaceDogNode *spaceDog;
    
    NSArray *textures;
    
    if (type == SpaceDogType_A) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        spaceDog.B_Type = YES;
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
    }
    
    float scale = [Util randomWithMin:65 max:100] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    
    [spaceDog setUpPhysicsBody];
    
    return spaceDog;
}

- (void) setUpPhysicsBody{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryProjectile | CollisionCategoryGround;
}

- (void) iveBeenHit {
    [self removeAllActions];
    SKTexture *woundedTextureA = [SKTexture textureWithImageNamed:@"spacedog_A_3"];
    SKTexture *woundedTextureB = [SKTexture textureWithImageNamed:@"spacedog_B_4"];
    if (self.B_Type) {
        self.texture = woundedTextureB;
    } else {
        self.texture = woundedTextureA;
    }
}


@end
