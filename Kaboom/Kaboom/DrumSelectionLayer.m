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
        
//        startMenuItem.isEnabled = NO;
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
        
        self.sharedTouchTracker = [TouchTracker sharedTouchTracker];
        
        NSString *defaultDrumEffect = @"d1.mp3";
        if (data.mode == MODE_ONE_DRUM) {
            [data.drumEffect setObject:defaultDrumEffect forKey:@"ONE"];
        } else if (data.mode == MODE_TWO_DRUM) {
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_LEFT"];
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_RIGHT"];
        } else if (data.mode == MODE_FOUR_DRUM) {
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_LEFT_TOP"];
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_LEFT_BOTTOM"];
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_RIGHT_TOP"];
            [data.drumEffect setObject:defaultDrumEffect forKey:@"TWO_RIGHT_BOTTOM"];
        }
	}
	return self;
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:10];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        for (CCSprite *drum in _drums) {
            if (CGRectContainsPoint(drum.boundingBox, location)){
                int currentDrum = [_drums indexOfObject:drum] + 1;
                int touchID = [self.sharedTouchTracker addNewTouch:(__bridge void *)(touch) withDrumIndex:currentDrum];
                if (touchID != -1) {
                    [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"d%d.mp3", currentDrum]];
                    CCSprite *draggedDrum = [CCSprite spriteWithTexture:[drum texture]];
                    draggedDrum.position = drum.position;
                    [self addChild:draggedDrum];
                    
                    [self.draggedDrums insertObject:draggedDrum atIndex:touchID];
                    break;
                }
            }
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int touchID = [self.sharedTouchTracker getTouchID:(__bridge void *)(touch)];
        if (touchID != -1) {
            CCSprite *dSprite = [self.draggedDrums objectAtIndex:touchID];
            dSprite.position = location;
        }
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int touchID = [self.sharedTouchTracker getTouchID:(__bridge void *)(touch)];
        if (touchID != -1) {
            CCSprite *dSprite = [self.draggedDrums objectAtIndex:touchID];
            dSprite.position = location;
            [self removeChild:dSprite cleanup:YES];
            [self checkDrumWithLocation:location andDrumIndex:self.sharedTouchTracker.touchTracks[touchID].drumIdx];
            self.sharedTouchTracker.touchTracks[touchID].touchPtr = 0;
        }
    }
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    TouchTracker *sharedTouchTracker = [TouchTracker sharedTouchTracker];
    for (UITouch* touch in touches) {
        int touchID = [sharedTouchTracker getTouchID:(__bridge void *)(touch)];
        if (touchID != -1) {
            self.sharedTouchTracker.touchTracks[touchID].touchPtr = 0;
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
        CGPoint leftTopDrumCenter = ccp(0, 0);
        CGPoint leftBottomDrumCenter = ccp(0, size.height);
        CGPoint rightTopDrumCenter = ccp(size.width, 0);
        CGPoint rightBottomDrumCenter = ccp(size.width, size.height);
        if ([self distanceBetween:location and:leftTopDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_LEFT_TOP"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
        } else if ([self distanceBetween:location and:leftBottomDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_LEFT_BOTTOM"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
        } else if ([self distanceBetween:location and:rightTopDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_RIGHT_TOP"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
        } else if ([self distanceBetween:location and:rightBottomDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:@"TWO_RIGHT_BOTTOM"];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
        }
    }

//    if ([data allDrumsAreSet]) {
//        [self readyToStart];
//    }
}


- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
