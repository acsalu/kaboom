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
    CCSprite *_oneDrum;
    CCSprite *_twoDrum;
    CCSprite *_fourDrum;
    NSMutableArray *_points;
}

+(CCScene *) scene;

@end
