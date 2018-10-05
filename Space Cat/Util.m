//
//  Util.m
//  Space Cat
//
//  Created by Chris William Sehnert on 9/21/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    return arc4random()%(max - min) + min;
}

@end
