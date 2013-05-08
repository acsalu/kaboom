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

@implementation DrumSprite

- (void)onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:TouchPriorityDrumSprite swallowsTouches:NO];
    _effectDict = [[KaboomGameData sharedData] drumEffect];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (void)removeBlinkSprite:(id)sender
{
    [[self parent] removeChild:sender cleanup:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView:[[CCDirector sharedDirector] view]];
    
    if (CGRectContainsPoint([_hitRect CGRectValue], touchLocation)) {
        CCSprite *blinkSprite = [CCSprite spriteWithFile:@"Drum_Bump_Red.png"];
        blinkSprite.position = self.position;
        blinkSprite.rotation = self.rotation;
        [[self parent] addChild:blinkSprite];
        
        id callback = [CCCallFuncN actionWithTarget:self selector:@selector(removeBlinkSprite:)];
        id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
        id easeScaleAction = [CCEaseInOut actionWithAction:scaleAction rate:2];
        CCSequence *sequence = [CCSequence actions:easeScaleAction, callback, nil];
        [blinkSprite runAction:sequence];
        
        [[SimpleAudioEngine sharedEngine] playEffect:_effectDict[_effectKey]];
        
        return YES;
    }
    
    return NO;
}

@end
