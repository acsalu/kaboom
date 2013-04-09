//
//  DrumSelectionLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "DrumSelectionLayer.h"
#import "KaboomGameData.h"
#import "SimpleAudioEngine.h"

#define ONE_DRUM_OFFST_Y 100
#define DRUM_DIFF_Y 192
#define SIDE_DRUM_DIFF_X 164
#define SIDE_DRUM_DIFF_Y 92

@implementation DrumSelectionLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DrumSelectionLayer *layer = [DrumSelectionLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        CGPoint center = ccp(size.width/2, size.height/2);
        
        background = [CCSprite spriteWithFile:@"drum-selection.png"];
        background.position = center;
       
        
        
        
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        NSString *drumImageName = nil;
        switch (data.mode) {
            case MODE_SINGLE_ONE:
                drumImageName = @"1p1d.png";
                break;
            case MODE_SINGLE_TWO:
                drumImageName = @"1p2d.png";
                break;
            case MODE_SINGLE_FOUR:
                drumImageName = @"1p4d.png";
                break;
            default:
                NSLog(@"fatal error, no game mode specified");
                exit(1);
        }
        
        CCSprite *drum = [CCSprite spriteWithFile:drumImageName];
        drum.position = center;
        
        CCMenuItem *startMenuItem = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"startp.png" block:^(id sender){
            CCLOG(@"start button pressed");
        }];
        
        NSLog(@"(w, h) = (%.0f, %.0f)", [startMenuItem boundingBox].size.width, [startMenuItem boundingBox].size.height);
        
        startMenuItem.isEnabled = NO;
        
        CCMenu *startMenu = [CCMenu menuWithItems:startMenuItem, nil];

        if (data.mode == MODE_SINGLE_ONE)
            startMenu.position = ccp(size.width / 2, size.height / 2 + ONE_DRUM_OFFST_Y);
        else
            startMenu.position = center;
        
        _initialLocations = @[[NSValue valueWithCGPoint:ccp(startMenu.position.x + SIDE_DRUM_DIFF_X, startMenu.position.y - SIDE_DRUM_DIFF_Y)],
                              [NSValue valueWithCGPoint:ccp(startMenu.position.x + SIDE_DRUM_DIFF_X, startMenu.position.y + SIDE_DRUM_DIFF_Y)],
                              [NSValue valueWithCGPoint:ccp(startMenu.position.x, startMenu.position.y + DRUM_DIFF_Y)],
                              [NSValue valueWithCGPoint:ccp(startMenu.position.x - SIDE_DRUM_DIFF_X, startMenu.position.y + SIDE_DRUM_DIFF_Y)],
                              [NSValue valueWithCGPoint:ccp(startMenu.position.x - SIDE_DRUM_DIFF_X, startMenu.position.y - SIDE_DRUM_DIFF_Y)],
                              [NSValue valueWithCGPoint:ccp(startMenu.position.x, startMenu.position.y - DRUM_DIFF_Y)]];
        
        CCSprite *d1 = [CCSprite spriteWithFile:@"d1.png"];
        d1.position = [_initialLocations[0] CGPointValue];
        
        CCSprite *d2 = [CCSprite spriteWithFile:@"d2.png"];
        d2.position = [_initialLocations[1] CGPointValue];
        
        CCSprite *d3 = [CCSprite spriteWithFile:@"d3.png"];
        d3.position = [_initialLocations[2] CGPointValue];
        
        CCSprite *d4 = [CCSprite spriteWithFile:@"d4.png"];
        d4.position = [_initialLocations[3] CGPointValue];
        
        CCSprite *d5 = [CCSprite spriteWithFile:@"d5.png"];
        d5.position = [_initialLocations[4] CGPointValue];
        
        CCSprite *d6 = [CCSprite spriteWithFile:@"d6.png"];
        d6.position = [_initialLocations[5] CGPointValue];
        
        
        
        [self addChild:background];
        [self addChild:startMenu];
        [self addChild:drum];
        [self addChild:d1];
        [self addChild:d2];
        [self addChild:d3];
        [self addChild:d4];
        [self addChild:d5];
        [self addChild:d6];
        
        _drums = @[d1, d2, d3, d4, d5, d6];
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    for (CCSprite *drum in _drums) {
        if (CGRectContainsPoint(drum.boundingBox,location) && _currentDrum == 0){
            _currentDrum = [_drums indexOfObject:drum] + 1;
            break;
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_currentDrum != 0) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        ((CCSprite *) _drums[_currentDrum - 1]).position = location;
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_currentDrum != 0) {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        CCSprite *drum = _drums[_currentDrum - 1];
        drum.position = location;
        [drum runAction:[CCMoveTo actionWithDuration:0.2f position:[_initialLocations[_currentDrum - 1] CGPointValue]]];
        _currentDrum = 0;
    }
}

@end
