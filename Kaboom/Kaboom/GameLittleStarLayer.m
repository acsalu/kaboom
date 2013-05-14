//
//  GameLittleStarLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "GameLittleStarLayer.h"
#import "KaboomGameData.h"
#import "Const.h"
#import "SimpleAudioEngine.h"
#import "Song.h"
#import "ShowResultLayer.h"
#import "SongSelectionLayer.h"



#define SCORE_FOR_EACH_HIT 1

@implementation GameLittleStarLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLittleStarLayer *layer = [GameLittleStarLayer node];
	
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
        
        DrumLayer *drumLayer = [data drumLayer];
        [drumLayer removeFromParentAndCleanup:NO];
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
        
        _song = [Song songStar];
        
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
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"star.mp3"];
        [self createScoreLabels];
        
        
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

- (void)createScoreLabels
{
    CGSize size = [CCDirector sharedDirector].winSize;
    _scoreLabels = [NSMutableDictionary dictionary];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:60];
    label.position = ccp(size.width * 0.2, size.height * 0.8);
    label.rotation = 120;
    label.color = ccc3(255, 255, 255);
    [self addChild:label];
    [_scoreLabels setObject:label forKey:DrumKey_LEFT_TOP];
    
    label = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:60];
    label.position = ccp(size.width * 0.8, size.height * 0.8);
    label.rotation = -120;
    label.color = ccc3(255, 255, 255);
    [self addChild:label];
    [_scoreLabels setObject:label forKey:DrumKey_RIGHT_TOP];
    
    label = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:60];
    label.position = ccp(size.width * 0.8, size.height * 0.2);
    label.rotation = -60;
    label.color = ccc3(255, 255, 255);
    [self addChild:label];
    [_scoreLabels setObject:label forKey:DrumKey_RIGHT_BOTTOM];
    
    label = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:60];
    label.position = ccp(size.width * 0.2, size.height * 0.2);
    label.rotation = 60;
    label.color = ccc3(255, 255, 255);
    [self addChild:label];
    [_scoreLabels setObject:label forKey:DrumKey_LEFT_BOTTOM];
    
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
    
    CGSize size = [CCDirector sharedDirector].winSize;
    
    for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
        
        if (note.intValue != NOTE_TYPE_REST) {
            
            CGPoint startingPoint = [Const startingPointWithNoteType:note.intValue];
            CGPoint destinationPoint = [Const destinationPointWithNoteType:note.intValue];
            NSString *drumKey = [Const drumKeyPointWithNoteType:note.intValue];
            
            ccTime duration = _song.interval;
            
            CCSprite *sprite;
            if (note.intValue <= NOTE_TYPE_IN3)
                sprite = [CCSprite spriteWithFile:@"notedot.png"];
            else
                sprite = [CCSprite spriteWithFile:@"notedot-arrow.png"];
            
            sprite.position = startingPoint;
            sprite.rotation = [Const rotationWithNoteType:note.intValue];
            
            CCSequence *sequence = [CCSequence actions:
                                     [CCMoveTo actionWithDuration:duration position:destinationPoint], nil];
            
            if (note.intValue == NOTE_TYPE_P_AB || note.intValue == NOTE_TYPE_P_CB ||
                note.intValue == NOTE_TYPE_P_DE || note.intValue == NOTE_TYPE_P_ED) {
                [_drumLayer addChild:sprite];
                id callback = [CCCallFuncND actionWithTarget:_drumLayer selector:@selector(removeChild:cleanup:) data:YES];
                [sprite runAction:[CCSequence actions:sequence, callback, nil]];
            } else
                [_drumLayer addNote:sprite ToDrum:drumKey WithActionSequence:sequence];
            
        }
    }
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
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameLittleStarLayer scene]]];
}

- (void)resumeButtonWasPressed:(id)sender{
    paused = NO;
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    [self resumeSchedulerAndActions];
    for(CCSprite *sprite in [self children]) {
        [[[CCDirector sharedDirector] actionManager] resumeTarget:sprite];
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
        [[[CCDirector sharedDirector] actionManager] pauseTarget:sprite];
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
    CCLabelTTF *scoreLabel = (CCLabelTTF *) [_scoreLabels objectForKey:drumKey];
    scoreLabel.string = [NSString stringWithFormat:@"%d", scoreLabel.string.intValue + score];
}


@end
