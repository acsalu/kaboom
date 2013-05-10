//
//  DrumLayer.h
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DrumSprite.h"


@protocol DrumLayerScorekeeperDelegate <NSObject>

@required
- (void)addScore:(int)score toDrum:(NSString *)drumKey;


@end


@interface DrumLayer : CCLayer <CCTargetedTouchDelegate, DrumSpriteDelegate>

@property (strong, nonatomic) NSMutableDictionary *drums;
@property (weak, nonatomic) id<DrumLayerScorekeeperDelegate> delegate;

- (void)addNote:(CCSprite *)note ToDrum:(NSString *)drumKey WithActionSequence:(CCSequence *)sequence;

@end
