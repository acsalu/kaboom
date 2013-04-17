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
#import "Const.h"
#import "SongSelectionLayer.h"
#import "CCTouchDispatcher.h"
#import "TouchTracker.h"

#define ONE_DRUM_OFFST_Y 100
#define DRUM_DIFF_Y 192
#define SIDE_DRUM_DIFF_X 164
#define SIDE_DRUM_DIFF_Y 92

#define START_MENU_TAG 0
#define START_ITEM_TAG 1

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

        self.draggedDrums = [NSMutableArray arrayWithCapacity:11];
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        CGPoint center = ccp(size.width/2, size.height/2);
        
        background = [CCSprite spriteWithFile:@"1-00.png"];
        background.position = center;
       
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        CCSprite *drum = [data drumSprite];
         
        CCMenuItem *startMenuItem = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"startp.png" block:^(id sender){
            CCLOG(@"start button pressed");
            [[CCDirector sharedDirector] replaceScene:[SongSelectionLayer scene]];
        }];
        
        NSLog(@"(w, h) = (%.0f, %.0f)", [startMenuItem boundingBox].size.width, [startMenuItem boundingBox].size.height);
        
        startMenuItem.isEnabled = NO;
        startMenuItem.tag = START_ITEM_TAG;
        
        CCMenu *startMenu = [CCMenu menuWithItems:startMenuItem, nil];
        startMenu.tag = START_MENU_TAG;
        
        if (data.mode == MODE_ONE_DRUM)
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

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:0];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        for (CCSprite *drum in _drums) {
            if (CGRectContainsPoint(drum.boundingBox, location)){
                int currentDrum = [_drums indexOfObject:drum] + 1;
                [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"d%d.mp3", currentDrum]];
                
                CCSprite *draggedDrum = [CCSprite spriteWithTexture:[drum texture]];
                draggedDrum.position = drum.position;
                [self addChild:draggedDrum];
                // should handle exception of touchID == -1 too
                int touchID = addNewTouch((__bridge void *)(touch), currentDrum);
                [self.draggedDrums insertObject:draggedDrum atIndex:touchID];
                break;
            }
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int touchID = getTouchID((__bridge void *)(touch));
        if (touchID != -1) {
            CCSprite *dSprite = [self.draggedDrums objectAtIndex:touchID];
            dSprite.position = location;
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int touchID = getTouchID((__bridge void *)(touch));
        if (touchID != -1) {
            CCSprite *dSprite = [self.draggedDrums objectAtIndex:touchID];
            dSprite.position = location;
            [self removeChild:dSprite cleanup:YES];
            [self checkDrumWithLocation:location andDrumIndex:touchTracker[touchID].drumIdx];
            touchTracker[touchID].touchPtr = 0;
        }
    }
}

- (void)readyToStart
{
    CCMenu *startMenu = (CCMenu *)[self getChildByTag:START_MENU_TAG];
    CCMenuItem *startButton = (CCMenuItem *)[startMenu getChildByTag:START_ITEM_TAG];
    startButton.isEnabled = YES;
}

- (void)checkDrumWithLocation:(CGPoint)location andDrumIndex:(int)drumIndex
{
    KaboomGameData *data = [KaboomGameData sharedData];
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSString *currentDrumEffect = [NSString stringWithFormat:@"d%d.mp3", drumIndex];
    if (data.mode == MODE_ONE_DRUM) {
        CGPoint drumCenter = ccp(size.width / 2, 0);
        if ([self distanceBetween:location and:drumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"ONE"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
        }
    } else if (data.mode == MODE_TWO_DRUM) {
        CGPoint leftDrumCenter = ccp(0, size.height / 2);
        CGPoint rightDrumCenter = ccp(size.width, size.height / 2);
        if ([self distanceBetween:location and:leftDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_LEFT"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            
        } else if ([self distanceBetween:location and:rightDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_RIGHT"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            
        }
        
    } else if (data.mode == MODE_FOUR_DRUM) {
        
    }
    
    if ([data allDrumsAreSet]) {
        [self readyToStart];
    }
}


- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
