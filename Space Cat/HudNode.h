//
//  HudNode.h
//  Space Cat
//
//  Created by Chris William Sehnert on 10/17/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HudNode : SKNode

@property(nonatomic) NSInteger lives;
@property(nonatomic) NSInteger score;


+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void) addPoints:(NSInteger)points;
- (BOOL) loseLife;

@end

NS_ASSUME_NONNULL_END
