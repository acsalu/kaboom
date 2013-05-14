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


- (void)addNote:(CCSprite *)note ToDrum:(NSString *)drumKey WithActionSequence:(CCSequence *)sequence
{
    DrumSprite *drum = [_drums objectForKey:drumKey];
    [drum.noteQueue addObject:note];
    [self addChild:note];
    [note runAction:sequence];
}

- (void)drum:(NSString *)drumKey Hit:(CCSprite *)note andGetScore:(int)score
{
    // do some effect
    if (score == 0) {
        CCTexture2D *redNote = [[CCTextureCache sharedTextureCache] addImage:@"notedot_red.png"];
        [note setTexture:redNote];
    } else {
        // star
    }
    
    // and then remove note
    [self removeChild:note cleanup:YES];
    
    [self.delegate addScore:score toDrum:drumKey];
}

@end
