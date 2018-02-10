//
//  PMAnimation.h
//  PopTeamEpicGame
//
//  Created by  zcating on 2018/2/9.
//  Copyright © 2018 com.zcating. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMAnimation : NSObject

@property (nonatomic, strong) NSMutableArray *images;

@property (readonly) NSTimeInterval duration;

+(instancetype) animation;
+(instancetype) animationWithCapacity:(NSUInteger)numImages;

@end
