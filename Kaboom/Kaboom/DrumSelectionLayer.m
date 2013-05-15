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
#import "DrumEffectSprite.h"
#import "DrumLayer.h"

#import "GESoundManager.h"

#define ONE_DRUM_OFFST_Y 100
#define DRUM_DIFF_Y 192
#define SIDE_DRUM_DIFF_X 164
#define SIDE_DRUM_DIFF_Y 92

#define START_MENU_TAG 0
#define START_ITEM_TAG 1
#define DRUM_LAYER_TAG 2

@implementation DrumSelectionLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	DrumSelectionLayer *layer = [DrumSelectionLayer node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        
        [[GESoundManager soleSoundManager] setDelegate:self];
        
        self.draggedDrums = [NSMutableArray arrayWithCapacity:11];
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint center = ccp(size.width/2, size.height/2);
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        CCSprite *background = (data.player == PLAYER_SINGLE) ? [CCSprite spriteWithFile:@"background2-landscape.png"] : [CCSprite spriteWithFile:@"background2-portrait.png"];
        background.position = ccp(size.width / 2, size.height / 2);
        
        CCSprite *startBackground = [CCSprite spriteWithFile:@"start_lightBack.png"];
        
        DrumLayer *drumLayer = [data drumLayer];
        drumLayer.tag = DRUM_LAYER_TAG;
        
        CCMenuItem *startMenuItem = [CCMenuItemImage itemWithNormalImage:@"start_light.png" selectedImage:@"start_dark.png" block:^(id sender) {
            
            id callbackReplaceScene = [CCCallBlock actionWithBlock:^{
                [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[SongSelectionLayer scene]]];
            }];
            
            id enlargeAction = [CCScaleTo actionWithDuration:0.15 scale:1.5];
            enlargeAction = [CCEaseOut actionWithAction:enlargeAction rate:2];
            id narrowAction = [CCScaleTo actionWithDuration:0.05 scale:1];
            narrowAction = [CCEaseInOut actionWithAction:narrowAction rate:2];
            id delay = [CCDelayTime actionWithDuration:0.2];
            CCSequence *actionsForDrumTap = [CCSequence actions:enlargeAction, narrowAction, delay, callbackReplaceScene, nil];
            
            [sender runAction:actionsForDrumTap];
            
        }];
        
        
        
        NSLog(@"(w, h) = (%.0f, %.0f)", [startMenuItem boundingBox].size.width, [startMenuItem boundingBox].size.height);
        
        startMenuItem.tag = START_ITEM_TAG;
        
        CCMenu *startMenu = [CCMenu menuWithItems:startMenuItem, nil];
        [startMenu alignItemsVertically];
        startMenu.tag = START_MENU_TAG;
        
        if (data.mode == MODE_ONE_DRUM)
            startBackground.position = startMenu.position = ccp(size.width / 2, size.height / 2 + ONE_DRUM_OFFST_Y);
        else
            startBackground.position = startMenu.position = center;
        
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
        [self addChild:startBackground];
        [self addChild:startMenu];
        [self addChild:drumLayer];
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
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_ONE];
        } else if (data.mode == MODE_TWO_DRUM) {
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_LEFT];
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_RIGHT];
        } else if (data.mode == MODE_FOUR_DRUM) {
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_LEFT_TOP];
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_RIGHT_TOP];
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_RIGHT_BOTTOM];
            [data.drumEffect setObject:defaultDrumEffect forKey:DrumKey_LEFT_BOTTOM];
        }
        


	}
	return self;
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:TouchPriorityDrumSelectionLayer swallowsTouches:NO];
}

- (void)onEnter
{
    [super onEnter];
    CCMenu *menu = (CCMenu *)[self getChildByTag:START_MENU_TAG];
    [[[CCDirector sharedDirector] touchDispatcher] setPriority:TouchPriorityStartButton forDelegate:menu];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
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
                
                id enlargeAction = [CCScaleTo actionWithDuration:0.15 scale:1.5];
                enlargeAction = [CCEaseOut actionWithAction:enlargeAction rate:2];
                id narrowAction = [CCScaleTo actionWithDuration:0.15 scale:1];
                narrowAction = [CCEaseInOut actionWithAction:narrowAction rate:2];
                CCSequence *actionsForDrumTap = [CCSequence actions:enlargeAction, narrowAction, nil];
                [draggedDrum runAction:actionsForDrumTap];
                
                return YES;
            }
        }
    }
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    int touchID = [self.sharedTouchTracker getTouchID:(__bridge void *)(touch)];
    if (touchID != -1) {
        CCSprite *dSprite = [self.draggedDrums objectAtIndex:touchID];
        dSprite.position = location;
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
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

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    TouchTracker *sharedTouchTracker = [TouchTracker sharedTouchTracker];
    int touchID = [sharedTouchTracker getTouchID:(__bridge void *)(touch)];
    if (touchID != -1) {
        self.sharedTouchTracker.touchTracks[touchID].touchPtr = 0;
        [self removeChild:[self.draggedDrums objectAtIndex:touchID] cleanup:YES];
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
    NSString *currentDrumEffect;
    currentDrumEffect = [NSString stringWithFormat:@"d%d.mp3", drumIndex];
//    } else {
//        [self openRecordLayer];
////        currentDrumEffect = [_audioPlayer.url absoluteString];
//        currentDrumEffect = @"d6.wav";
//    }
    
    DrumLayer *drumLayer = (DrumLayer *)[self getChildByTag:DRUM_LAYER_TAG];
    
    if (data.mode == MODE_ONE_DRUM) {
        NSString *currentDrum = [NSString stringWithFormat:@"drum_2_%d.png", drumIndex];
        CCTexture2D *currentDrumTexture = [[CCTextureCache sharedTextureCache] addImage:currentDrum];
        CGPoint drumCenter = ccp(size.width / 2, 0);
        if ([self distanceBetween:location and:drumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_ONE];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_ONE] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_ONE];
            }
        }
    } else if (data.mode == MODE_TWO_DRUM) {
        NSString *currentDrum = [NSString stringWithFormat:@"drum_2_%d.png", drumIndex];
        CCTexture2D *currentDrumTexture = [[CCTextureCache sharedTextureCache] addImage:currentDrum];
        CGPoint leftDrumCenter = ccp(0, size.height / 2);
        CGPoint rightDrumCenter = ccp(size.width, size.height / 2);
        if ([self distanceBetween:location and:leftDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_LEFT];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_LEFT] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_LEFT];
            }
            
        } else if ([self distanceBetween:location and:rightDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_RIGHT];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_RIGHT] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_RIGHT];
            }
        }
        
    } else if (data.mode == MODE_FOUR_DRUM) {
        NSString *currentDrum = [NSString stringWithFormat:@"drum_4_%d.png", drumIndex];
        CCTexture2D *currentDrumTexture = [[CCTextureCache sharedTextureCache] addImage:currentDrum];
        CGPoint leftTopDrumCenter = ccp(0, size.height);
        CGPoint rightTopDrumCenter = ccp(size.width, size.height);
        CGPoint rightBottomDrumCenter = ccp(size.width, 0);
        CGPoint leftBottomDrumCenter = ccp(0, 0);
        if ([self distanceBetween:location and:leftTopDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_LEFT_TOP];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_LEFT_TOP] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_LEFT_TOP];
            }
        } else if ([self distanceBetween:location and:rightTopDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_RIGHT_TOP];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_RIGHT_TOP] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_RIGHT_TOP];
            }
        } else if ([self distanceBetween:location and:rightBottomDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_RIGHT_BOTTOM];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_RIGHT_BOTTOM] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_RIGHT_BOTTOM];
            }
        } else if ([self distanceBetween:location and:leftBottomDrumCenter] < kDrumEffectiveRadius) {
            [data.drumEffect setObject:currentDrumEffect forKey:DrumKey_LEFT_BOTTOM];
            [[SimpleAudioEngine sharedEngine] playEffect:currentDrumEffect];
            [[drumLayer.drums objectForKey:DrumKey_LEFT_BOTTOM] setTexture:currentDrumTexture];
            if ([currentDrumEffect isEqualToString:@"d6.mp3"]) {
                [[GESoundManager soleSoundManager] openRecordLayerForDrum:DrumKey_LEFT_BOTTOM];
            }
        }
    }
}


- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

- (void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}




@end
