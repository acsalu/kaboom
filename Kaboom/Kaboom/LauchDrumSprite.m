//
//  LauchDrumSprite.m
//  Kaboom
//
//  Created by LCR on 5/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LauchDrumSprite.h"


@implementation LauchDrumSprite

- (void)onEnter
{
    [super onEnter];
    
//    [self showAnimation];
}

- (void)showAnimation
{
    id small = [CCScaleTo actionWithDuration:0.01 scale:0.0];
    id delay = [CCDelayTime actionWithDuration:0.5];
    id scaleAction = [CCScaleTo actionWithDuration:0.3 scale:1.3];
    //    scaleAction = [CCEaseInOut actionWithAction:scaleAction rate:2];
    id restoreAction = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    restoreAction = [CCEaseInOut actionWithAction:restoreAction rate:2];
    CCSequence *sequence = [CCSequence actions:small, delay, scaleAction, restoreAction, nil];
    [self runAction:sequence];
}



@end
