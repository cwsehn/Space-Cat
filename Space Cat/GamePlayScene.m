//
//  GamePlayScene.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/16/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"
#import "SpaceCatNode.h"
#import "ProjectileNode.h"
#import "SpaceDogNode.h"
#import "GroundNode.h"
#import "Util.h"

@interface GamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;


@end

@implementation GamePlayScene

- (void)sceneDidLoad {
    // Setup your scene here
    
    self.lastUpdateTimeInterval = 0;
    self.timeSinceEnemyAdded = 0;
    self.totalGameTime = 0;
    self.addEnemyTimeInterval = 1.25;
    self.minSpeed = spaceDogMinSpeed;
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    MachineNode *machine = [MachineNode machineAtPosition: CGPointMake(CGRectGetMidX(self.frame), 12)];
    [self addChild:machine];
    
    SpaceCatNode *spacecat = [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
    [self addChild:spacecat];
    
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
    [self addChild:ground];
    
    [self setUpSounds];
    
}

- (void) update:(NSTimeInterval)currentTime {
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval) {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480) {
        // 8minutes
        self.addEnemyTimeInterval = 0.50;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240) {
        // 4minutes
        self.addEnemyTimeInterval = 0.65;
        self.minSpeed = -150;
    } else if (self.totalGameTime > 120) {
        // 2minutes
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -125;
    } else if (self.totalGameTime > 30) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -100;
    }
    
}

- (void) setUpSounds {
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
}

- (void) shootProjectileTowardsPosition:(CGPoint)position {
    SpaceCatNode *spaceCat = (SpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    MachineNode *machineNode = (MachineNode*)[self childNodeWithName:@"Machine"];
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:CGPointMake(machineNode.position.x, machineNode.position.y + machineNode.frame.size.height-15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
    
    [self runAction:self.laserSFX];
    
}

- (void) addSpaceDog {
    NSUInteger randomSpaceDog = [Util randomWithMin:0 max:2];
    float dy = [Util randomWithMin:spaceDogMinSpeed max:spaceDogMaxSpeed];
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogOfType:randomSpaceDog];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [Util randomWithMin:10 + spaceDog.size.width max:self.frame.size.width - spaceDog.size.width - 10];
    spaceDog.position = CGPointMake(x, y);
    
    [self addChild:spaceDog];
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    
    SKPhysicsBody *firstBody, *secondBody;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
        secondBody.categoryBitMask == CollisionCategoryProjectile) {
        NSLog(@"BAM!");
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode *)secondBody.node;
        [spaceDog removeFromParent];
        [projectile removeFromParent];
        [self runAction:self.explodeSFX];
    } else if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
               secondBody.categoryBitMask == CollisionCategoryGround) {
        NSLog(@"Hit Ground");
        [self runAction:self.damageSFX];
        SpaceDogNode *spaceDog = (SpaceDogNode *)firstBody.node;
        [spaceDog removeFromParent];
        
    }
    [self createDebrisAtPosition:contact.contactPoint];
}

-(void) createDebrisAtPosition: (CGPoint)position {
    NSInteger numberOfPieces = [Util randomWithMin:5 max:20];
    
    for (int i=0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Util randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d", (int)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";
        debris.physicsBody.velocity = CGVectorMake([Util randomWithMin:-150 max:150], [Util randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
}



@end