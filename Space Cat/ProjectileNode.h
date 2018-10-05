//
//  ProjectileNode.h
//  Space Cat
//
//  Created by Chris William Sehnert on 9/21/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface ProjectileNode : SKSpriteNode

+ (instancetype) projectileAtPosition: (CGPoint)position;
- (void) moveTowardsPosition: (CGPoint)position;
@end


