//
//  LauchDrumSprite.m
//  Kaboom
//
//  Created by LCR on 5/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LauchDrumSprite.h"


@implementation LauchDrumSprite

- (void)showAnimation
{
    id scaleToZero = [CCScaleTo actionWithDuration:0.0 scale:0.0];
    id delay = [CCDelayTime actionWithDuration:0.2];
    id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:1.3];
    scaleAction = [CCEaseOut actionWithAction:scaleAction rate:3.0];
    id restoreAction = [CCScaleTo actionWithDuration:0.1 scale:1.0];
    restoreAction = [CCEaseInOut actionWithAction:restoreAction rate:2];
    CCSequence *sequence = [CCSequence actions:scaleToZero, delay, scaleAction, restoreAction, nil];
    [self runAction:sequence];
}



@end
