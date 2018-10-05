//
//  TitleScene.h
//  Space Cat
//
//  Created by Chris William Sehnert on 9/14/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface TitleScene : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end
