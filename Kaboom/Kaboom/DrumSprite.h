//
//  DrumSprite.h
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

extern const int EFFECT_HIT_DISTANCE;
extern const int SCORE_DISTANCE_LOWER_BOUND;
extern const int SCORE_DISTANCE_HIGHER_BOUND;

@protocol DrumSpriteDelegate <NSObject>

@required
- (void)drum:(NSString *)drumKey Hit:(CCSprite *)note andGetScore:(int)score;

@end


@interface DrumSprite : CCSprite <CCTargetedTouchDelegate>

@property (weak, nonatomic) id<DrumSpriteDelegate> delegate;

@property (strong, nonatomic) NSValue *hitRect;
@property (strong, nonatomic) NSString *drumKey;
@property (strong, nonatomic) NSMutableDictionary *effectDict;
@property (strong, nonatomic) NSMutableArray *noteQueue;

- (void)showAnimation;

@end
