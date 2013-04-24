//
//  SlapSprite.m
//  Kaboom
//
//  Created by LCR on 4/24/13.
//
//

#import "SlapSprite.h"

@implementation SlapSprite

- (void)onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
    CCDirector *director = [CCDirector sharedDirector];
    CGPoint location = [touch locationInView:director.view];
    location = [director convertToGL:location];
    if (CGRectContainsPoint([self boundingBox], location)) {
        NSLog(@"i slap this drum hoho");
        return YES;
    }
    return NO;
}

@end
