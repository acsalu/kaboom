//
//  DrumLayer.m
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DrumLayer.h"
#import "DrumSprite.h"
#import "SimpleAudioEngine.h"
#import "KaboomGameData.h"
#import "Const.h"
#import "Utility.h"

@implementation DrumLayer

- (id)init
{
    if (self = [super init]) {
        self.isTouchEnabled = YES;
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        // for demo
        data.mode = MODE_FOUR_DRUM;
        _hitRects = [Const getDrumHitRects];
        _noteQueue = [NSMutableArray array];
        
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
        
    }
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    KaboomGameData *data = [KaboomGameData sharedData];
    NSArray *hitRects = [Const getDrumHitRects];
    
    if (data.player == PLAYER_SINGLE) {
        if (data.mode == MODE_ONE_DRUM) {
//            CCSprite *drum_1p1 = [CCSprite spriteWithFile:@"Drum_Bump_Red.png"];
//            drum_1p1.position = [Const basePointForDrum:0];
//            [self addChild:drum_1p1];
        }
        else if (data.mode == MODE_TWO_DRUM) {
//            CCSprite *drum_1p1 = [CCSprite spriteWithFile:@"Drum_Bump_Red.png"];
//            drum_1p1.position = [Const basePointForDrum:0];
//            CCSprite *drum_1p2 = [CCSprite spriteWithFile:@"Drum_Bump_Red.png"];
//            drum_1p2.position = [Const basePointForDrum:1];
//            [self addChild:drum_1p1];
//            [self addChild:drum_1p2];
        } else {
            DrumSprite *drum_1p1 = [DrumSprite spriteWithFile:@"drum_4_red.png"];
            DrumSprite *drum_1p2 = [DrumSprite spriteWithFile:@"drum_4_red.png"];
            DrumSprite *drum_1p3 = [DrumSprite spriteWithFile:@"drum_4_red.png"];
            DrumSprite *drum_1p4 = [DrumSprite spriteWithFile:@"drum_4_red.png"];
            drum_1p1.position = [Const basePointForDrum:0];
            drum_1p1.rotation = 90;
            drum_1p1.hitRect = hitRects[0];
            drum_1p1.effectKey = DrumKey_LEFT_TOP;
            drum_1p2.position = [Const basePointForDrum:1];
            drum_1p2.rotation = 180;
            drum_1p2.hitRect = hitRects[1];
            drum_1p2.effectKey = DrumKey_RIGHT_TOP;
            drum_1p3.position = [Const basePointForDrum:2];
            drum_1p3.rotation = 270;
            drum_1p3.hitRect = hitRects[2];
            drum_1p3.effectKey = DrumKey_RIGHT_BOTTOM;
            drum_1p4.position = [Const basePointForDrum:3];
            drum_1p4.hitRect = hitRects[3];
            drum_1p4.effectKey = DrumKey_LEFT_BOTTOM;
            [self addChild:drum_1p1];
            [self addChild:drum_1p2];
            [self addChild:drum_1p3];
            [self addChild:drum_1p4];
        }
//    } else {
//        if (data.mode == MODE_TWO_DRUM) imageName = @"2p2d.png";
//        else imageName = @"2p4d.png";
//    }
    }

}

- (void)registerWithTouchDispatcher
{
    // for test, set swallowtouches to NO. reset to YES?
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:TouchPriorityDrumLayer swallowsTouches:NO];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    KaboomGameData *data = [KaboomGameData sharedData];
    
    for (NSValue *rectValue in _hitRects) {
        if (CGRectContainsPoint([rectValue CGRectValue], touchLocation)) {
            int index = [_hitRects indexOfObject:rectValue];
            NSMutableArray *queue = _noteQueue[[_hitRects indexOfObject:rectValue]];
            if (queue.count > 0) {
                CCSprite *note = queue[0];
                if ([Utility distanceBetween:note.position and:[Const basePointForDrum:index]] < kDrumEffectiveRadius) {
//                    [self updateScoresWithNote:note forDrum:[_hitRects indexOfObject:rectValue]];
//                    [self removeNote:note];
                    NSLog(@"hit ; queue is not empty");
                }
            }
            
            return YES;
        }
    }
    
    return NO;
}



@end
