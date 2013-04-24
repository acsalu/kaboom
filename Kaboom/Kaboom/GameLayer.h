//
//  GameLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "cocos2d.h"

@class Song;
@interface GameLayer : CCLayer {
    CCSprite *pauseButton;
    CCSprite *pausedSprite;
    CCMenu *pausedMenu;
    BOOL paused;
}

- (void)quitButtonWasPressed:(id)sender;
- (void)restartButtonWasPressed:(id)sender;
- (void)resumeButtonWasPressed:(id)sender;

+(CCScene *) scene;

@property (strong, nonatomic) NSArray *hitRects;
@property (nonatomic) int count;
@property (strong, nonatomic) CCSprite *countdownSprite;
@property (nonatomic) bool isPause;
@property (strong, nonatomic) Song *song;
@property (strong, nonatomic) NSMutableArray *noteQueue;
@property (strong, nonatomic) NSMutableArray *scores;

@end
