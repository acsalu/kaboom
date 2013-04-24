//
//  GameLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "GameLayer.h"
#import "KaboomGameData.h"
#import "Const.h"
#import "SimpleAudioEngine.h"
#import "Song.h"
#import "SongSelectionLayer.h"

#define SCORE_DISTANCE_LOWER_BOUND 660
#define SCORE_DISTANCE_HIGHER_BOUND 680

#define SCORE_FOR_EACH_HIT 1

@implementation GameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        _noteQueue = [NSMutableArray array];
        KaboomGameData *data = [KaboomGameData sharedData];
        data.mode = MODE_FOUR_DRUM;
        switch (data.mode) {
            case MODE_ONE_DRUM:
                [_noteQueue addObjectsFromArray:@[[NSMutableArray array], [NSMutableArray array]]];
                break;
            case MODE_TWO_DRUM:
                [_noteQueue addObjectsFromArray:@[[NSMutableArray array], [NSMutableArray array]]];
                break;
            case MODE_FOUR_DRUM:
                [_noteQueue addObjectsFromArray:@[[NSMutableArray array], [NSMutableArray array], [NSMutableArray array], [NSMutableArray array]]];
                break;
            default:
                break;
        }
        
        _scores = [NSMutableArray arrayWithCapacity:data.player];
        for (int i = 0; i < data.player; ++i) _scores[i] = @(0);
        
        _hitRects = [Const getDrumHitRects];
        for (NSValue *rectValue in _hitRects) {
            CGRect rect = [rectValue CGRectValue];
            NSLog(@"rect (%.0f, %.0f)(%.0f, %.0f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        }
        
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        CCSprite *background = (data.player == PLAYER_SINGLE) ? [CCSprite spriteWithFile:@"background3-landscape.png"] : [CCSprite spriteWithFile:@"background3-portrait.png"];
        background.position = ccp(size.width * 1 / 2, size.height / 2);
        
        CCSprite *drum = [data drumSprite];
        
        [self createPauseButton];
        [self createPausedMenu];
        
        CCMenuItem *sourcedot = [CCMenuItemImage itemWithNormalImage:@"sourcedot.png" selectedImage:@"sourcedot.png" block:^(id sender) {
            NSLog(@"should open pause menu!");
        }];
        
        sourcedot.position = ccp(size.width / 2, size.height / 2);
        
        [self addChild:background];
        [self addChild:drum];
        [self addChild:sourcedot];
        
        _song = [Song newSong];
        
        float delay = _song.interval;
        _count = 3;
        [self schedule:@selector(countdown:) interval:delay];
	}
	return self;
}

- (void)countdown:(ccTime)delta
{
    if (_count == 0) {
        [self removeChild:_countdownSprite cleanup:YES];
        [self unschedule:@selector(countdown:)];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"time machine.mp3"];
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
        [self schedule:@selector(fire:) interval:[_song lengthInFloat:((NSNumber *) _song.melody[_song.currentIdx][@"length"]).intValue]];        
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
    CCLOG(@"%d", _song.currentIdx);
    CGSize size = [[CCDirector sharedDirector] winSize];
    for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
        CCLOG(@"%@", [Song noteTypeString:note.intValue]);
        
        if (note.intValue != NOTE_TYPE_REST) {
            CGPoint destinationPointP1;
            CGPoint destinationPointP2;
            NSMutableArray *queue1;
            NSMutableArray *queue2;
            
            switch (note.intValue) {
                case NOTE_TYPE_REST:
                    return;
                case NOTE_TYPE_LEFT:
                case NOTE_TYPE_BOUNCE_LR:
                    destinationPointP1 = ccp(0 + size.width * 0.05, 0 + size.height * 0.05);
                    destinationPointP2 = ccp(size.width * 0.95, size.height * 0.95);
                    queue1 = _noteQueue[3];
                    queue2 = _noteQueue[1];
                    break;
                case NOTE_TYPE_RIGHT:
                case NOTE_TYPE_BOUNCE_RL:
                    destinationPointP1 = ccp(0 + size.width * 0.05, size.height * 0.95);
                    destinationPointP2 = ccp(size.width * 0.95, 0 + size.height * 0.05);
                    queue1 = _noteQueue[0];
                    queue2 = _noteQueue[2];
                    
                    break;
                case  NOTE_TYPE_CLAP:
                    destinationPointP1 = ccp(0, size.height / 2);
                    destinationPointP2 = ccp(size.width, size.height / 2);
                    break;
                
                default:
                    break;
            }
            
            
        id callback = [CCCallFuncN actionWithTarget:self selector:@selector(removeNote:)];
            
        CCSprite *note1;
        
        CCSequence *sequence1;
        if (note.intValue == NOTE_TYPE_BOUNCE_LR) {
            sequence1 = [CCSequence actions:[CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP1],
                         [CCMoveTo actionWithDuration:_song.interval * 0.5 position:ccp(0 + size.width * 0.05, size.height * 0.95)],
                         callback, nil];
            note1 = [CCSprite spriteWithFile:@"notedot-arrow-L2R.png"];
            note1.rotation = -90;
        } else if (note.intValue == NOTE_TYPE_BOUNCE_RL) {
            sequence1 = [CCSequence actions:[CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP1],
                         [CCMoveTo actionWithDuration:_song.interval * 0.5 position:ccp(0 + size.width * 0.05, 0 + size.height * 0.05)],
                         callback, nil];
            note1 = [CCSprite spriteWithFile:@"notedot-arrow-R2L.png"];
            note1.rotation = -90;
        } else {
            sequence1 = [CCSequence actions: [CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP1],
            callback, nil];
            note1 = [CCSprite spriteWithFile:@"notedot.png"];
        }
            
        note1.position = ccp(size.width / 2, size.height / 2);
        [self addChild:note1];
        [note1 runAction:sequence1];
        [queue1 addObject:note1];
    
        CCSprite *note2;
        

        CCSequence *sequence2;
        if (note.intValue == NOTE_TYPE_BOUNCE_LR) {
            sequence2 = [CCSequence actions:[CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP2],
                         [CCMoveTo actionWithDuration:_song.interval * 0.5 position:ccp(size.width * 0.95, 0 + size.height * 0.05)],
                         callback, nil];
            note2 = [CCSprite spriteWithFile:@"notedot-arrow-L2R.png"];
            note2.rotation = 90;
        } else if (note.intValue == NOTE_TYPE_BOUNCE_RL) {
            sequence2 = [CCSequence actions:[CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP2],
                         [CCMoveTo actionWithDuration:_song.interval * 0.5 position:ccp(size.width * 0.95, size.height * 0.95)],
                         callback, nil];
            note2 = [CCSprite spriteWithFile:@"notedot-arrow-R2L.png"];
            note2.rotation = 90;
        } else {
            sequence2 = [CCSequence actions: [CCMoveTo actionWithDuration:_song.interval * 2 position:destinationPointP2],
                         callback, nil];
            note2 = [CCSprite spriteWithFile:@"notedot.png"];
        }
        
        note2.position = ccp(size.width / 2, size.height / 2);
        [self addChild:note2];
        [note2 runAction:sequence2];
        [queue2 addObject:note2];
        }
    }
    [self startGameLoop];
}

- (void)removeNote:(id)note
{
    [self stopAllActions];
    [self removeChild:note cleanup:YES];
    for (NSMutableArray *queue in _noteQueue) {
        if ([queue containsObject:note]) {
            [queue removeObject:note];
            break;
        }
    }
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
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCDirector* director = [CCDirector sharedDirector];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:director.view];
//        NSLog(@"(%.0f, %.0f)", p.x, p.y);
        for (NSValue *rectValue in _hitRects) {
            if (CGRectContainsPoint([rectValue CGRectValue], p)) {
                NSLog(@"HIT! at drum %d", [_hitRects indexOfObject:rectValue]);
                CCSprite *closest;
                NSMutableArray *queue = _noteQueue[[_hitRects indexOfObject:rectValue]];
                if (queue.count > 0) {
                    [self updateScoresWithNote:queue[0] forDrum:[_hitRects indexOfObject:rectValue]];
                    [self removeNote:queue[0]];
                }
                
//                CGFloat distance = 5000;
//                for (CCSprite *note in _noteQueue) {
//                    if ([self distanceBetween:p and:note.position] < distance) closest = note;
//                }
//                
//                if (closest) {
//                    [self removeNote:closest];
//                }
                
                KaboomGameData *data = [KaboomGameData sharedData];
                NSString *effect = data.drumEffect[@"drum1"];
                if (effect) [[SimpleAudioEngine sharedEngine] playEffect:effect];
                else [[SimpleAudioEngine sharedEngine] playEffect:@"d1.mp3"];
            }
        }
    }
    
}

- (void)updateScoresWithNote:(CCSprite *)note forDrum:(int)drumId
{
    CGPoint basePoint = [Const basePointForDrum:drumId];
    CCLOG(@"basePoint (%.0f, %.0f)", basePoint.x, basePoint.y);
    CGFloat distance = [self distanceBetween:note.position and:basePoint];
    CCLOG(@"distance %f", distance);
    if (distance <= SCORE_DISTANCE_HIGHER_BOUND && distance >= SCORE_DISTANCE_LOWER_BOUND) {
        int playerId = [Const playerIdForDrum:drumId];
        CCLOG(@"player %d SCORES!", playerId);
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
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameLayer scene]]];
}

- (void)resumeButtonWasPressed:(id)sender{
    
    paused = NO;
    
    // hide the sprite that shows the word 'Paused' from view
    [pausedSprite runAction:[CCMoveTo actionWithDuration:0.3
                                                position:ccp([CCDirector sharedDirector].winSize.width/2,
                                                             [CCDirector sharedDirector].winSize.height + 700)]];
    // hide the paued menu from view
    [pausedMenu runAction:[CCMoveTo actionWithDuration:0.3
                                              position:ccp([CCDirector sharedDirector].winSize.width/2,
                                                           [CCDirector sharedDirector].winSize.height + 700)]];
    
}

- (void)pauseButtonWasPressed:(id)sender {
    
    paused = YES;
    
    [pausedSprite runAction:[CCMoveTo actionWithDuration:0.3
                                                position:ccp([CCDirector sharedDirector].winSize.width/2,
                                                             [CCDirector sharedDirector].winSize.height/2)]];
    KaboomGameData *data = [KaboomGameData sharedData];
    
    if (data.player == PLAYER_SINGLE) {
        [pausedMenu runAction:[CCMoveTo actionWithDuration:0.3
                                                  position:ccp([CCDirector sharedDirector].winSize.width/2 - 100,
                                                               [CCDirector sharedDirector].winSize.height/2)]];
    }
    else if (data.player == PLAYER_TWO) {
        [pausedMenu runAction:[CCMoveTo actionWithDuration:0.3
                                                  position:ccp([CCDirector sharedDirector].winSize.width/2,
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
        [self addChild:pausedMenu z:100];
    }
}


@end
