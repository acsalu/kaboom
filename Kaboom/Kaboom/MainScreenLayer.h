//
//  MainScreenLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

extern const int DRUM_ONE;
extern const int DRUM_TWO_LEFT;
extern const int DRUM_TWO_RIGHT;
extern const int DRUM_FOUR_UPPER_LEFT;
extern const int DRUM_FOUR_UPPER_RIGHT;
extern const int DRUM_FOUR_LOWER_RIGHT;
extern const int DRUM_FOUR_LOWER_LEFT;

@interface MainScreenLayer : CCLayer
{
    CCSprite *_oneDrum1P;
    CCSprite *_twoDrum1P;
    CCSprite *_fourDrum1P;
    CCSprite *_twoDrum2P;
    CCSprite *_fourDrum2P;
    NSMutableArray *_points;
    NSMutableSet *_drums;
    
}

@property (nonatomic) int detectCounter;

+(CCScene *) scene;

@end
