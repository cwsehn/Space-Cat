//
//  SpaceDogNode.h
//  Space Cat
//
//  Created by Chris William Sehnert on 9/23/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SpaceDogType) {
    SpaceDogType_A = 0,
    SpaceDogType_B = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface SpaceDogNode : SKSpriteNode
+ (instancetype) spaceDogOfType: (SpaceDogType)type;
@property (nonatomic) BOOL wounded;
@property (nonatomic) BOOL B_Type;
- (void) iveBeenHit;

@end

NS_ASSUME_NONNULL_END
