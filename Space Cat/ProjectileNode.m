//
//  ProjectileNode.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/21/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "ProjectileNode.h"
#import "Util.h"

@implementation ProjectileNode

+ (instancetype) projectileAtPosition: (CGPoint)position {
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    [projectile setupAnimation];
    
    return projectile;
};

- (void) setupAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction];
    [self setUpPhysicsBody];
}

- (void) setUpPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}

- (void) moveTowardsPosition: (CGPoint)position {
    // create directional animation for projectile ...to offscreen...
    // position argument is CGPoint of touch on screen...
    // self.position is intial position of calling Projectile established in GamePlayScene...
    
    float slope = 0.001;
    if (position.x != self.position.x) {
        slope = (position.y - self.position.y) / (position.x - self.position.x);
    }

    float offscreenX;
    
    if (position.x <= self.position.x) {
        offscreenX = -10;
    } else {
        offscreenX = self.parent.frame.size.width + 10;
    }
    
    float offscreenY = slope * offscreenX - slope * self.position.x + self.position.y;
    
    CGPoint offscreenPoint = CGPointMake(offscreenX, offscreenY);
    
    float distanceA = offscreenPoint.y - self.position.y;
    float distanceB = offscreenPoint.x - self.position.x;
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    float time = distanceC / ProjectileSpeed;
    float waitTime = time * 0.75;
    float fadeTime = time - waitTime;
    
    SKAction *moveProjectile = [SKAction moveTo:offscreenPoint duration:time];
    [self runAction:moveProjectile];
    SKAction *waitToFade = [SKAction waitForDuration:waitTime];
    SKAction *fadeProjectile = [SKAction fadeOutWithDuration:fadeTime];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *projectileSequence = [SKAction sequence:@[waitToFade, fadeProjectile, removeNode]];
    
    [self runAction:projectileSequence];
    
}




@end
