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

#import "GESoundManager.h"

const int EFFECT_HIT_DISTANCE = 550;
const int SCORE_DISTANCE_LOWER_BOUND = 0;
const int SCORE_DISTANCE_HIGHER_BOUND = 450;

@implementation DrumSprite


- (void)onEnter
{
    [super onEnter];
    self.visible = NO;
    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:TouchPriorityDrumSprite swallowsTouches:NO];
    _effectDict = [[KaboomGameData sharedData] drumEffect];
    _noteQueue = [NSMutableArray array];
    
    [self showAnimation];
    
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (void)showAnimation
{
    id scaleToZero = [CCScaleTo actionWithDuration:0.0 scale:0.0];
    id delay = [CCDelayTime actionWithDuration:0.5];
    id beVisible = [CCCallBlock actionWithBlock:^{ self.visible = YES; }];
    id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
    scaleAction = [CCEaseOut actionWithAction:scaleAction rate:3.0];
    id restoreAction = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    restoreAction = [CCEaseInOut actionWithAction:restoreAction rate:2];
    CCSequence *sequence = [CCSequence actions:scaleToZero, delay, beVisible, scaleAction, restoreAction, nil];
    [self runAction:sequence];
}

- (void)removeBlinkSprite:(id)sender
{
    [[self parent] removeChild:sender cleanup:YES];
}

- (void)blink
{
    CCSprite *blinkSprite = [CCSprite spriteWithTexture:[self texture]];
    blinkSprite.position = self.position;
    blinkSprite.rotation = self.rotation;
    [[self parent] addChild:blinkSprite];
    
    id callback = [CCCallFuncN actionWithTarget:self selector:@selector(removeBlinkSprite:)];
    id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
    id easeScaleAction = [CCEaseInOut actionWithAction:scaleAction rate:2];
    CCSequence *sequence = [CCSequence actions:easeScaleAction, callback, nil];
    [blinkSprite runAction:sequence];
    
    NSString *effect = _effectDict[_drumKey];
    if ([effect rangeOfString:@"d6"].location == NSNotFound) {
        [[SimpleAudioEngine sharedEngine] playEffect:effect];
        
    } else {
        [[GESoundManager soleSoundManager] playEffect:effect];
    
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    
    if (CGRectContainsPoint([_hitRect CGRectValue], touchLocation)) {
        
        [self blink];
        
        if (_noteQueue.count > 0) {
            CCSprite *note = _noteQueue[0];
            CGFloat distance = [Utility distanceBetween:note.position and:self.position];

            if (distance < EFFECT_HIT_DISTANCE) {
                if (SCORE_DISTANCE_LOWER_BOUND < distance && distance < SCORE_DISTANCE_HIGHER_BOUND) {
                    [self.delegate drum:self.drumKey Hit:note andGetScore:1];
                } else {
                    [self.delegate drum:self.drumKey Hit:note andGetScore:0];
                }
            }
        }

        
        return YES;
    }
    
    return NO;
}

@end
