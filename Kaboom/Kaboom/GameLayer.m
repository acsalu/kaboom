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
        _hitRects = [Const getDrumHitRects];
        for (NSValue *rectValue in _hitRects) {
            CGRect rect = [rectValue CGRectValue];
            NSLog(@"rect (%.0f, %.0f)(%.0f, %.0f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        }
        
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"1-00.png"];
        background.position = ccp(- size.width * 1 / 2, size.height / 2);
        KaboomGameData *data = [KaboomGameData sharedData];
        
        CCSprite *drum = [data drumSprite];
        
        CCMenuItem *sourcedot = [CCMenuItemImage itemWithNormalImage:@"sourcedot.png" selectedImage:@"sourcedot.png" block:^(id sender) {
            NSLog(@"should open pause menu!");
        }];
        
        sourcedot.position = ccp(size.width / 2, size.height / 2);
        
        [self addChild:background];
        [self addChild:drum];
        [self addChild:sourcedot];
        
        _song = [Song newSong];
        
        float delay = 1.0f;
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
        [self fire:0.0f];
    } else {
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
    if (_song.currentIdx == _song.melody.count) return;
    CCLOG(@"%d", _song.currentIdx);
    for (NSNumber *note in _song.melody[_song.currentIdx][@"notes"]) {
        CCLOG(@"%@", [Song noteTypeString:note.intValue]);
    }
    [self startGameLoop];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCDirector* director = [CCDirector sharedDirector];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:director.view];
        NSLog(@"(%.0f, %.0f)", p.x, p.y);
        for (NSValue *rectValue in _hitRects) {
            if (CGRectContainsPoint([rectValue CGRectValue], p)) {
                NSLog(@"HIT!");
                KaboomGameData *data = [KaboomGameData sharedData];
                NSString *effect = data.drumEffect[@"drum1"];
                if (effect) [[SimpleAudioEngine sharedEngine] playEffect:effect];
                else [[SimpleAudioEngine sharedEngine] playEffect:@"d1.mp3"];
            }
        }
    }
    
}

@end
