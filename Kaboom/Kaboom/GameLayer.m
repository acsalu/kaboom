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
        
        
        _hitRects = [Const getDrumHitRects];
        for (NSValue *rectValue in _hitRects) {
            CGRect rect = [rectValue CGRectValue];
            NSLog(@"rect (%.0f, %.0f)(%.0f, %.0f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        }
        
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"1-00.png"];
        background.position = ccp(- size.width * 1 / 2, size.height / 2);
        
        CCSprite *drum = [data drumSprite];
        
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
    
//    CCLOG(@"%@", _song.melody);
//    while (_song.currentIdx < _song.melody.count) {
//        NSString *msg = [Song noteLengthString:((NSNumber *) _song.melody[_song.currentIdx][@"length"]).intValue];
//        for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
//            msg = [NSString stringWithFormat:@"%@ %@", msg, [Song noteTypeString:note.intValue]];
//        }
//        CCLOG(@"%@", msg);
//        ++_song.currentIdx;
//    }
    if (_song.currentIdx < _song.melody.count) {
//        NSString *msg = [Song noteLengthString:((NSNumber *) _song.melody[_song.currentIdx][@"length"]).intValue];
//        
//        
//        for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
//            msg = [NSString stringWithFormat:@"%@ %@", msg, [Song noteTypeString:note.intValue]];
//        }
//        CCLOG(@"%@", msg);
        [self schedule:@selector(fire:) interval:[_song lengthInFloat:((NSNumber *) _song.melody[_song.currentIdx][@"length"]).intValue]];        
        ++_song.currentIdx;
    }

}


- (void)fire:(ccTime)delta
{
    [self unschedule:@selector(fire:)];
    if (_song.currentIdx == _song.melody.count) {
        [self schedule:@selector(showScore:) interval:1.0f];
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
    CCLOG(@"show score");
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

- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
