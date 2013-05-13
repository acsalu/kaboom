//
//  GameSonataLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "GameSonataLayer.h"
#import "KaboomGameData.h"
#import "Const.h"
#import "SimpleAudioEngine.h"
#import "Song.h"
#import "ShowResultLayer.h"
#import "SongSelectionLayer.h"



#define SCORE_FOR_EACH_HIT 1

@implementation GameSonataLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameSonataLayer *layer = [GameSonataLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        KaboomGameData *data = [KaboomGameData sharedData];
        _scores = [NSMutableArray arrayWithCapacity:data.player];
        for (int i = 0; i < data.player; ++i) _scores[i] = @(0);
        
        CCSprite *background = (data.player == PLAYER_SINGLE) ? [CCSprite spriteWithFile:@"background3-landscape.png"] : [CCSprite spriteWithFile:@"background3-portrait.png"];
        background.position = ccp(size.width * 1 / 2, size.height / 2);
        
        //        CCSprite *drum = [data drumSprite];
        DrumLayer *drumLayer = [data drumLayer];
        drumLayer.delegate = self;
        _drumLayer = drumLayer;
        
        [self createPauseButton];
        [self createPausedMenu];
        
        CCMenuItem *sourcedot = [CCMenuItemImage itemWithNormalImage:@"sourcedot.png" selectedImage:@"sourcedot.png" block:^(id sender) {
            NSLog(@"should open pause menu!");
        }];
        
        sourcedot.position = ccp(size.width / 2, size.height / 2);
        
        [self addChild:background];
        [self addChild:drumLayer];
        [self addChild:sourcedot];
        
        _song = [Song songSonata];
        
        float delay = _song.interval;
        _count = 3;
        [self schedule:@selector(countdown:) interval:delay];
	}
	return self;
}

- (void)countdown:(ccTime)delta
{
    if (_count < 0) {
        [self removeChild:_countdownSprite cleanup:YES];
        [self unschedule:@selector(countdown:)];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"sonata.mp3"];
    } else {
        if (_count == 1) [self fire:0.0f];
        CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint center = ccp(size.width / 2, size.height / 2);
        if (_countdownSprite) [self removeChild:_countdownSprite cleanup:YES];
        _countdownSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"countdown-%d.png", _count]];
        _countdownSprite.position = center;
        [self addChild:_countdownSprite];
        --_count;
    }
}

- (void)startGameLoop
{
    if (_song.currentIdx < _song.melody.count) {
        ccTime interval;
        NoteType type = ((NSNumber *) _song.melody[_song.currentIdx][@"notes"][0]).intValue;
        if (type == NOTE_TYPE_BOUNCE_LR1 || type == NOTE_TYPE_BOUNCE_RL1)
            interval = 2 * _song.interval;
        else
            interval = [_song lengthInFloat:((NSNumber *) _song.melody[_song.currentIdx][@"length"]).intValue];
        [self schedule:@selector(fire:) interval:interval];
        ++_song.currentIdx;
    }
}

- (void)fire:(ccTime)delta
{
    [self unschedule:@selector(fire:)];
    if (_song.currentIdx == _song.melody.count) {
        [self schedule:@selector(showScore:) interval:1.0f];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        return;
    }
    //    CCLOG(@"%d", _song.currentIdx);
    CGSize size = [[CCDirector sharedDirector] winSize];
    for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
        //        CCLOG(@"%@", [Song noteTypeString:note.intValue]);
        
        if (note.intValue != NOTE_TYPE_REST) {
            
            CGPoint startingPoint = ccp(size.width / 2, size.height / 2);
            id callback = [CCCallFuncND actionWithTarget:_drumLayer selector:@selector(removeChild:cleanup:) data:YES];
            ccTime duration = _song.interval;
            
            if ([KaboomGameData sharedData].mode == MODE_ONE_DRUM) {
                
                CCSprite *note = [CCSprite spriteWithFile:@"notedot.png"];
                
                note.position = startingPoint;
                
                CGPoint destinationPoint = ccp (size.width / 2, size.height * 0.07);
                
                CCSequence *sequence = [CCSequence actions:
                                         [CCMoveTo actionWithDuration:duration position:destinationPoint], callback, nil];
                
                [_drumLayer addNote:note ToDrum:DrumKey_ONE WithActionSequence:sequence];
                
                
            } else if ([KaboomGameData sharedData].mode == MODE_TWO_DRUM) {
                
                CCSprite *note1 = [CCSprite spriteWithFile:@"notedot.png"];
                CCSprite *note2 = [CCSprite spriteWithFile:@"notedot.png"];
                
                note1.position = startingPoint;
                note2.position = startingPoint;
                
                CGPoint destinationPoint1 = ccp(size.width * 0.07, size.height / 2);
                CGPoint destinationPoint2 = ccp(size.width * 0.93, size.height / 2);
                
                CCSequence *sequence1 = [CCSequence actions:
                                        [CCMoveTo actionWithDuration:duration position:destinationPoint1], callback, nil];
                CCSequence *sequence2 = [CCSequence actions:
                                        [CCMoveTo actionWithDuration:duration position:destinationPoint2], callback, nil];
                
                [_drumLayer addNote:note1 ToDrum:DrumKey_LEFT WithActionSequence:sequence1];
                [_drumLayer addNote:note2 ToDrum:DrumKey_RIGHT WithActionSequence:sequence2];
                
            } else {
                
                CCSprite *note1 = [CCSprite spriteWithFile:@"notedot.png"];
                CCSprite *note2 = [CCSprite spriteWithFile:@"notedot.png"];
                CCSprite *note3 = [CCSprite spriteWithFile:@"notedot.png"];
                CCSprite *note4 = [CCSprite spriteWithFile:@"notedot.png"];
                
                note1.position = startingPoint;
                note2.position = startingPoint;
                note3.position = startingPoint;
                note4.position = startingPoint;
                
                CGPoint destinationPoint1 = ccp(size.width * 0.07, size.height * 0.93);
                CGPoint destinationPoint2 = ccp(size.width * 0.93, size.height * 0.93);
                CGPoint destinationPoint3 = ccp(size.width * 0.93, size.height * 0.07);
                CGPoint destinationPoint4 = ccp(size.width * 0.07, size.height * 0.07);
                
                CCSequence *sequence1 = [CCSequence actions:
                                         [CCMoveTo actionWithDuration:duration position:destinationPoint1], callback, nil];
                CCSequence *sequence2 = [CCSequence actions:
                                         [CCMoveTo actionWithDuration:duration position:destinationPoint2], callback, nil];
                CCSequence *sequence3 = [CCSequence actions:
                                         [CCMoveTo actionWithDuration:duration position:destinationPoint3], callback, nil];
                CCSequence *sequence4 = [CCSequence actions:
                                         [CCMoveTo actionWithDuration:duration position:destinationPoint4], callback, nil];

                [_drumLayer addNote:note1 ToDrum:DrumKey_LEFT_TOP WithActionSequence:sequence1];
                [_drumLayer addNote:note2 ToDrum:DrumKey_RIGHT_TOP WithActionSequence:sequence2];
                [_drumLayer addNote:note3 ToDrum:DrumKey_RIGHT_BOTTOM WithActionSequence:sequence3];
                [_drumLayer addNote:note4 ToDrum:DrumKey_LEFT_BOTTOM WithActionSequence:sequence4];
            }
            
        }}
    [self startGameLoop];
}



- (void)showScore:(ccTime)delta
{
    [self unschedule:@selector(showScore:)];
    CCLOG(@"show score");
    int total = [_song totalBeatableNotes];
    CCLOG(@"total %d beatable notes", total);
    for (NSNumber *score in _scores) {
        NSLog(@"player%d - %@", [_scores indexOfObject:score], score);
    }
    CCLayer *scoreLayer = [ShowResultLayer showResultLayerWithScore:_scores andTotalNotes:total];
    if ([[KaboomGameData sharedData] player] == PLAYER_TWO) {
        scoreLayer.rotation = 90;
    }
    [self addChild:scoreLayer];
}

- (void)updateScoresWithNote:(CCSprite *)note forDrum:(int)drumId
{
    CGPoint basePoint = [Const basePointForDrum:drumId];
    //    CCLOG(@"basePoint (%.0f, %.0f)", basePoint.x, basePoint.y);
    CGFloat distance = [self distanceBetween:note.position and:basePoint];
    //    CCLOG(@"distance %f", distance);
    if (distance <= SCORE_DISTANCE_HIGHER_BOUND && distance >= SCORE_DISTANCE_LOWER_BOUND) {
        int playerId = [Const playerIdForDrum:drumId];
        //        CCLOG(@"player %d SCORES!", playerId);
        _scores[playerId] = @(((NSNumber *) _scores[playerId]).integerValue + SCORE_FOR_EACH_HIT);
    }
}

- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

- (void)quitButtonWasPressed:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[SongSelectionLayer scene]]];
}

- (void)restartButtonWasPressed:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameSonataLayer scene]]];
}

- (void)resumeButtonWasPressed:(id)sender{
    paused = NO;
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    [self resumeSchedulerAndActions];
    for(CCSprite *sprite in [self children]) {
        [[CCActionManager sharedManager] resumeTarget:sprite];
    }
    
    [pausedSprite runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2,
                                                            [CCDirector sharedDirector].winSize.height + 700)]];
    
    
    [pausedMenu runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2,
                                                          [CCDirector sharedDirector].winSize.height + 700)]];
    
}

- (void)pauseButtonWasPressed:(id)sender {
    paused = YES;
    
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [self pauseSchedulerAndActions];
    for(CCSprite *sprite in [self children]) {
        [[CCActionManager sharedManager] pauseTarget:sprite];
    }
    
    [pausedSprite runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height/2)]];
    
    KaboomGameData *data = [KaboomGameData sharedData];
    
    if (data.player == PLAYER_SINGLE) {
        [pausedMenu runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2 - 100,
                                                              [CCDirector sharedDirector].winSize.height/2)]];
    }
    else if (data.player == PLAYER_TWO) {
        [pausedMenu runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2,
                                                              [CCDirector sharedDirector].winSize.height/2 - 150)]];
    }
    
    
}
- (void)createPauseButton {
    
    // create sprite for the pause button
    pauseButton = [CCSprite spriteWithFile:@"startp.png"];    // horizonal or vertical
    
    // create menu item for the pause button from the pause sprite
    CCMenuItemSprite *item = [CCMenuItemSprite itemWithNormalSprite:pauseButton
                                                     selectedSprite:nil
                                                             target:self
                                                           selector:@selector(pauseButtonWasPressed:)];
    
    // create menu for the pause button and put the menu item on the menu
    CCMenu *menu = [CCMenu menuWithItems: item, nil];
    [menu setAnchorPoint:ccp(0, 0)];
    [menu setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height/2)];
    [self addChild:menu];
}

- (void)createPausedMenu {
    
    KaboomGameData *data = [KaboomGameData sharedData];
    
    if (data.player == PLAYER_SINGLE) {
        pausedSprite = [CCSprite spriteWithFile:@"pause_horizontal_ipad.png"];
        
        CCMenuItemSprite *item1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"resume_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(resumeButtonWasPressed:)];
        
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"restart_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(restartButtonWasPressed:)];
        
        CCMenuItemSprite *item3 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"menu_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(quitButtonWasPressed:)];
        
        pausedMenu = [CCMenu menuWithItems:item1, item2, item3, nil];
        [pausedMenu alignItemsInColumns: [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        [pausedMenu alignItemsVerticallyWithPadding:40];
        
        // create the paused sprite and paused menu buttons off screen
        [pausedSprite setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height + 700)];
        [pausedMenu setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height + 700)];
        
        // add the Paused sprite and menu to the current layer
        [self addChild:pausedSprite z:100];
        [self addChild:pausedMenu z:100];
        
    }
    else if (data.player == PLAYER_TWO){
        pausedSprite = [CCSprite spriteWithFile:@"pause_vertical_ipad.png"];
        
        CCMenuItemSprite *item1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"resume_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(resumeButtonWasPressed:)];
        
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"restart_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(restartButtonWasPressed:)];
        
        CCMenuItemSprite *item3 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"menu_ipad.png"]
                                                          selectedSprite:nil
                                                                  target:self
                                                                selector:@selector(quitButtonWasPressed:)];
        
        pausedMenu = [CCMenu menuWithItems:item1, item2, item3, nil];
        [pausedMenu alignItemsInRows: [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
        [pausedMenu alignItemsVerticallyWithPadding:40];
        
        // create the paused sprite and paused menu buttons off screen
        [pausedSprite setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height + 700)];
        [pausedMenu setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height + 700)];
        
        // add the Paused sprite and menu to the current layer
        [self addChild:pausedSprite z:100];
        [self addChild:pausedMenu z:100];    }
}

- (void)addScore:(int)score toDrum:(NSString *)drumKey
{
    CCLOG(@"[score] %d at %@", score, drumKey);
}


@end
