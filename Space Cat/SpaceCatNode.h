//
//  SpaceCatNode.h
//  Space Cat
//
//  Created by Chris William Sehnert on 9/17/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SpaceCatNode : SKSpriteNode

+ (instancetype) spaceCatAtPosition: (CGPoint)position;

- (void) performTap;

@end
