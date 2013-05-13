//
//  GameLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "cocos2d.h"
#import "DrumLayer.h"

@class Song;
@interface GameLayer : CCLayer <DrumLayerScorekeeperDelegate>
{
    CCSprite *pauseButton;
    CCSprite *pausedSprite;
    CCMenu *pausedMenu;
    BOOL paused;
}

- (void)quitButtonWasPressed:(id)sender;
- (void)restartButtonWasPressed:(id)sender;
- (void)resumeButtonWasPressed:(id)sender;

+(CCScene *) scene;

@property (nonatomic) int count;
@property (strong, nonatomic) CCSprite *countdownSprite;
@property (nonatomic) bool isPause;
@property (strong, nonatomic) Song *song;
@property (strong, nonatomic) NSMutableArray *scores;

@property (strong, nonatomic) DrumLayer *drumLayer;

@end
