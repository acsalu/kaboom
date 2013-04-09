//
//  MainScreenLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"




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

+(CCScene *) scene;

@end
