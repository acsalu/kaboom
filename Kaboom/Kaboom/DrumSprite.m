//
//  DrumSprite.m
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DrumSprite.h"
#import "SimpleAudioEngine.h"
#import "Const.h"
#import "Utility.h"
#import "KaboomGameData.h"

const int SCORE_DISTANCE_LOWER_BOUND = 150;
const int SCORE_DISTANCE_HIGHER_BOUND = 200;

@implementation DrumSprite

- (void)onEnter
{
    [super onEnter];
    
    [self showAnimation];
    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:TouchPriorityDrumSprite swallowsTouches:NO];
    _effectDict = [[KaboomGameData sharedData] drumEffect];
    
    _noteQueue = [NSMutableArray array];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (void)showAnimation
{
    id small = [CCScaleTo actionWithDuration:0.01 scale:0.1];
    id delay = [CCDelayTime actionWithDuration:0.3];
    id scaleAction = [CCScaleTo actionWithDuration:0.3 scale:1.3];
    //    scaleAction = [CCEaseInOut actionWithAction:scaleAction rate:2];
    id restoreAction = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    restoreAction = [CCEaseInOut actionWithAction:restoreAction rate:2];
    CCSequence *sequence = [CCSequence actions:small, delay, scaleAction, restoreAction, nil];
    [self runAction:sequence];
}

- (void)removeBlinkSprite:(id)sender
{
    [[self parent] removeChild:sender cleanup:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    
    if (CGRectContainsPoint([_hitRect CGRectValue], touchLocation)) {
        CCSprite *blinkSprite = [CCSprite spriteWithTexture:[self texture]];
        blinkSprite.position = self.position;
        blinkSprite.rotation = self.rotation;
        [[self parent] addChild:blinkSprite];
        
        id callback = [CCCallFuncN actionWithTarget:self selector:@selector(removeBlinkSprite:)];
        id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
        id easeScaleAction = [CCEaseInOut actionWithAction:scaleAction rate:2];
        CCSequence *sequence = [CCSequence actions:easeScaleAction, callback, nil];
        [blinkSprite runAction:sequence];
        
        [[SimpleAudioEngine sharedEngine] playEffect:_effectDict[_drumKey]];
        
        if (_noteQueue.count > 0) {
            CCSprite *note = _noteQueue[0];
            CGFloat distance = [Utility distanceBetween:note.position and:[Const basePointForDrum:index]];
            if (distance < kDrumEffectiveRadius) {
                if (SCORE_DISTANCE_LOWER_BOUND < distance && distance > SCORE_DISTANCE_HIGHER_BOUND) {
                    [self.delegate drum:self.drumKey Hit:note andGetScore:1];
                } else {
                    [self.delegate drum:self.drumKey Hit:note andGetScore:0];
                }
            }
            [self.noteQueue removeObject:note];
        }

        
        return YES;
    }
    
    return NO;
}

@end
