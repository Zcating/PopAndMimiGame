//
//  PMAnimation.m
//  PopTeamEpicGame
//
//  Created by  zcating on 2018/2/9.
//  Copyright © 2018 com.zcating. All rights reserved.
//

#import "PMAnimation.h"

@implementation PMAnimation

+(instancetype)animation {
    return [[PMAnimation alloc] initWithCapacity:1];
}

+(instancetype)animationWithCapacity:(NSUInteger)numImages {
    return [[PMAnimation alloc] initWithCapacity:numImages];
}

- (instancetype)initWithCapacity:(NSUInteger)numImages {
    self = [super init];
    if (self) {
        self.images = [NSMutableArray arrayWithCapacity:numImages];
    }
    return self;
}

-(NSTimeInterval)duration {
    return (float)self.images.count / 24;
}

@end
