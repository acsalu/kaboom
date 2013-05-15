//
//  DrumLayer.m
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DrumLayer.h"
#import "SimpleAudioEngine.h"
#import "KaboomGameData.h"
#import "Const.h"
#import "Utility.h"

@implementation DrumLayer

- (id)init
{
    if (self = [super init]) {
        
        _drums = [[NSMutableDictionary alloc] init];

        [self setDrumSprites];
    }
    return self;
}

- (void)setDrumSprites
{
    KaboomGameData *data = [KaboomGameData sharedData];
    NSArray *hitRects = [Const getDrumHitRects];
    
    if (data.mode == MODE_ONE_DRUM) {
        DrumSprite *drum_1 = [DrumSprite spriteWithFile:@"drum_2_1.png"];
        drum_1.delegate = self;
        drum_1.position = [Const basePointForDrum:0];
        drum_1.hitRect = hitRects[0];
        drum_1.drumKey = DrumKey_ONE;
        [self addChild:drum_1];
        [_drums setObject:drum_1 forKey:DrumKey_ONE];

    }
    else if (data.mode == MODE_TWO_DRUM) {
        DrumSprite *drum_1 = [DrumSprite spriteWithFile:@"drum_2_1.png"];
        drum_1.delegate = self;
        drum_1.position = [Const basePointForDrum:0];
        drum_1.rotation = 90;
        drum_1.hitRect = hitRects[0];
        drum_1.drumKey = DrumKey_LEFT;
        DrumSprite *drum_2 = [DrumSprite spriteWithFile:@"drum_2_1.png"];
        drum_2.delegate = self;
        drum_2.position = [Const basePointForDrum:1];
        drum_2.rotation = 270;
        drum_2.hitRect = hitRects[1];
        drum_2.drumKey = DrumKey_RIGHT;
        [self addChild:drum_1];
        [self addChild:drum_2];
        [_drums setObject:drum_1 forKey:DrumKey_LEFT];
        [_drums setObject:drum_2 forKey:DrumKey_RIGHT];
        
    } else {
        DrumSprite *drum_1 = [DrumSprite spriteWithFile:@"drum_4_1.png"];
        drum_1.delegate = self;
        drum_1.position = [Const basePointForDrum:0];
        drum_1.rotation = 90;
        drum_1.hitRect = hitRects[0];
        drum_1.drumKey = DrumKey_LEFT_TOP;
        DrumSprite *drum_2 = [DrumSprite spriteWithFile:@"drum_4_1.png"];
        drum_2.delegate = self;
        drum_2.position = [Const basePointForDrum:1];
        drum_2.rotation = 180;
        drum_2.hitRect = hitRects[1];
        drum_2.drumKey = DrumKey_RIGHT_TOP;
        DrumSprite *drum_3 = [DrumSprite spriteWithFile:@"drum_4_1.png"];
        drum_3.delegate = self;
        drum_3.position = [Const basePointForDrum:2];
        drum_3.rotation = 270;
        drum_3.hitRect = hitRects[2];
        drum_3.drumKey = DrumKey_RIGHT_BOTTOM;
        DrumSprite *drum_4 = [DrumSprite spriteWithFile:@"drum_4_1.png"];
        drum_4.delegate = self;
        drum_4.position = [Const basePointForDrum:3];
        drum_4.hitRect = hitRects[3];
        drum_4.drumKey = DrumKey_LEFT_BOTTOM;
        [self addChild:drum_1];
        [self addChild:drum_2];
        [self addChild:drum_3];
        [self addChild:drum_4];
        [_drums setObject:drum_1 forKey:DrumKey_LEFT_TOP];
        [_drums setObject:drum_2 forKey:DrumKey_RIGHT_TOP];
        [_drums setObject:drum_3 forKey:DrumKey_RIGHT_BOTTOM];
        [_drums setObject:drum_4 forKey:DrumKey_LEFT_BOTTOM];
    }
}

- (void)removeNote:(CCSprite *)note FromDrum:(NSString *)drumKey
{
    [self removeChild:note cleanup:YES];
    DrumSprite *drum = [_drums objectForKey:drumKey];
    [drum.noteQueue removeObject:note];
}

- (void)addNote:(CCSprite *)note ToDrum:(NSString *)drumKey WithActionSequence:(CCSequence *)sequence
{
    DrumSprite *drum = [_drums objectForKey:drumKey];
    [self addChild:note];
    [drum.noteQueue addObject:note];
    
    id callback = [CCCallFuncND actionWithTarget:self selector:@selector(removeNote:FromDrum:) data:(__bridge void *)(drumKey)];
    sequence = [CCSequence actions:sequence, callback, nil];
    [note runAction:sequence];
}

- (void)drum:(NSString *)drumKey Hit:(CCSprite *)note andGetScore:(int)score
{
    
    // and then remove note
    [self removeNote:note FromDrum:drumKey];
    
    NSLog(@"hit");
    if (score == 0) {
        CCSprite *redNote = [CCSprite spriteWithFile:@"notedot_red.png"];
        redNote.position = note.position;
        id fadeOut = [CCFadeOut actionWithDuration:0.5];
        id callback = [CCCallFuncND actionWithTarget:self selector:@selector(removeChild:cleanup:) data:YES];
        CCSequence *s = [CCSequence actions:fadeOut, callback, nil];
        [self addChild:redNote];
        [redNote runAction:s];
        
    } else {
        NSLog(@"score");
        [self starBlinkAt:drumKey];
//        DrumSprite *drum = [_drums objectForKey:drumKey];
//        CCSprite *star = [CCSprite spriteWithFile:@"hitstar1.png"];
//        star.position = drum.position;
//        star.rotation = drum.rotation;
//        [self addChild:star];

        
    }
    
    [self.delegate addScore:score toDrum:drumKey];
}

- (void)removeStarBlink:(id)sender
{
    [self removeChild:sender cleanup:YES];
}


- (void)starBlinkAt:(NSString *)drumKey
{
    DrumSprite *drum = [_drums objectForKey:drumKey];
    CCSprite *star = [CCSprite spriteWithFile:@"hitstar_4.png"];
    star.position = drum.position;
    star.rotation = drum.rotation;
    [self addChild:star];
    
    id callback = [CCCallFuncN actionWithTarget:self selector:@selector(removeStarBlink:)];
    id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
    id easeScaleAction = [CCEaseOut actionWithAction:scaleAction rate:2];
    CCSequence *sequence = [CCSequence actions:easeScaleAction, callback, nil];
    [star runAction:sequence];
}

@end
