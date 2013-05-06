//
//  DrumEffectSprite.m
//  Kaboom
//
//  Created by LCR on 4/24/13.
//
//

#import "DrumEffectSprite.h"

@implementation DrumEffectSprite

- (void)onEnter
{
    [super onEnter];
    _touchTracks = [[NSMutableDictionary alloc] init];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-10 swallowsTouches:YES];
}

- (void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCDirector *director = [CCDirector sharedDirector];
    CGPoint location = [touch locationInView:director.view];
    location = [director convertToGL:location];
    if (CGRectContainsPoint([self boundingBox], location)) {
        NSLog(@"i slap this drum hoho");
        CCSprite *draggedSprite = [CCSprite spriteWithFile:@"d1.png"];
        draggedSprite.position = self.position;
        [[self parent] addChild:draggedSprite];
        NSValue *touchPtr = [NSValue valueWithPointer:(__bridge const void *)(touch)];
        [self.touchTracks setObject:draggedSprite forKey:touchPtr];
        return YES;
    }
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCDirector *director = [CCDirector sharedDirector];
    CGPoint location = [touch locationInView:director.view];
    location = [director convertToGL:location];
    
    NSValue *touchPtr = [NSValue valueWithPointer:(__bridge const void *)(touch)];
    CCSprite *d = [_touchTracks objectForKey:touchPtr];
    d.position = location;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

@end
