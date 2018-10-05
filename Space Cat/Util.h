//
//  Util.h
//  Space Cat
//
//  Created by Chris William Sehnert on 9/21/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static const int ProjectileSpeed = 400;
static const int spaceDogMinSpeed = -100;
static const int spaceDogMaxSpeed = -50;

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryEnemy      = 1 << 0,   // 0001
    CollisionCategoryProjectile = 1 << 1,   // 0010
    CollisionCategoryDebris     = 1 << 2,   // 0100
    CollisionCategoryGround     = 1 << 3    // 1000
};

@interface Util : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end

NS_ASSUME_NONNULL_END
