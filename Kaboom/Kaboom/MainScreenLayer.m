//
//  MainScreenLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "MainScreenLayer.h"
#import "AppDelegate.h"
#import "KaboomGameData.h"
#import "DrumSelectionLayer.h"

#define DETECTION_AREA_WIDTH 130
#define DETECTION_AREA_HEIGHT 130

const int DRUM_ONE               = 0;
const int DRUM_TWO_LEFT          = 1;
const int DRUM_TWO_RIGHT         = 2;
const int DRUM_FOUR_UPPER_LEFT   = 3;
const int DRUM_FOUR_UPPER_RIGHT  = 4;
const int DRUM_FOUR_LOWER_RIGHT  = 5;
const int DRUM_FOUR_LOWER_LEFT   = 6;

#define BACKGROUND_TAG 1000

@implementation MainScreenLayer


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MainScreenLayer *layer = [MainScreenLayer node];
	[scene addChild: layer];

	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        _points = [NSMutableArray array];
        _drums = [NSMutableSet set];
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
            data.player = PLAYER_TWO;
            background = [CCSprite spriteWithFile:@"background1-portrait.png"];
        } else {
            data.player = PLAYER_SINGLE;
            background = [CCSprite spriteWithFile:@"background1-landscape.png"];
        }
        background.position = ccp(size.width / 2, size.height / 2);
        background.tag = BACKGROUND_TAG;
        
        
        LanchDrumLayer *launchDrumLayer = [LanchDrumLayer node];
        _lanchDrumLayer = launchDrumLayer;
        
        
        [self addChild:background];
        [self addChild:launchDrumLayer];
        
        // SETUP DEVICE ORIENTATION CHANGE NOTIFICATION
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
	}
	return self;
}

- (void)setDetectCounter:(int)detectCounter
{
    _detectCounter = detectCounter;
    KaboomGameData *data = [KaboomGameData sharedData];
    
    if ((data.mode == MODE_ONE_DRUM && _detectCounter == 1) ||
        (data.mode == MODE_TWO_DRUM && _detectCounter == 2) ||
        (data.mode == MODE_FOUR_DRUM && _detectCounter == 4))
        [self schedule:@selector(makeTransition:) interval:0.5f];
}

- (void)orientationChanged:(NSNotification *)notification
{
    NSLog(@"Orientation has changed: %d", [[notification object] orientation]);
    UIInterfaceOrientation orientation = [[notification object] orientation];
    KaboomGameData *data = [KaboomGameData sharedData];
    if (UIInterfaceOrientationIsPortrait(orientation) && data.player != PLAYER_TWO) {
        data.player = PLAYER_TWO;
        [self changeInterface];
    } else if (UIInterfaceOrientationIsLandscape(orientation) && data.player != PLAYER_SINGLE){
        data.player = PLAYER_SINGLE;
        [self changeInterface];
    }
}

- (void)changeInterface
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLOG(@"winsize (%.0f, %.0f)", size.width, size.height);
    
    
    KaboomGameData *data = [KaboomGameData sharedData];
    if (data.player == PLAYER_SINGLE) CCLOG(@"PLAYER_1P");
    else CCLOG(@"PLAYER_MULTI");
    NSString *bgImageName = (data.player == PLAYER_SINGLE) ? @"background1-landscape.png" : @"background1-portrait.png";
    CGPoint bgPosition = ccp(size.width / 2, size.height / 2);
    [self removeChildByTag:BACKGROUND_TAG cleanup:YES];
    
    CCSprite *background = [CCSprite spriteWithFile:bgImageName];
    background.tag = BACKGROUND_TAG;
    background.position = bgPosition;
    [self addChild:background z:-1];
    
    [_lanchDrumLayer changeOrientation];
    
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCDirector* director = [CCDirector sharedDirector];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:director.view];
        NSLog(@"(%.0f, %.0f)", p.x, p.y);
        [_points addObject:[NSValue valueWithCGPoint:p]];
    }
    
    [self changeDisplay];
}



- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCDirector* director = [CCDirector sharedDirector];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:director.view];
        int idx = 0;
        CGFloat distance = [self distanceBetween:p and:[_points[0] CGPointValue]];
        for (int i = 1; i < _points.count; ++i) {
            CGFloat d = [self distanceBetween:p and:[_points[i] CGPointValue]];
            if (d < distance) {
                distance = d;
                idx = i;
            }
        }
        _points[idx] = [NSValue valueWithCGPoint:p];
    }
    
    [self changeDisplay];
    
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CCDirector* director = [CCDirector sharedDirector];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInView:director.view];
        int idx = 0;
        CGFloat distance = [self distanceBetween:p and:[_points[0] CGPointValue]];
        for (int i = 1; i < _points.count; ++i) {
            CGFloat d = [self distanceBetween:p and:[_points[i] CGPointValue]];
            if (d < distance) {
                distance = d;
                idx = i;
            }
        }
        [_points removeObjectAtIndex:idx];
    }
    [self changeDisplay];
}

- (void)makeDisapear:(CCNode *)node
{
    if (!node.visible) return;
    
    //if (!node.visible) return;
    //CCAction *action2 = [CCHide action];
    [node runAction:[CCFadeOut actionWithDuration:1.0f]];
    node.visible = NO;
}


- (void)makeShow:(CCNode *)node
{
    if (node.visible) return;
    node.visible = YES;
    [node runAction:[CCFadeIn actionWithDuration:1.0f]];
    /*
     if (node.visible) return;
     CCAction *action1 = [CCFadeOut actionWithDuration:0.3];
     CCAction *action2 = [CCShow action];
     [node runAction:[CCSequence actions:action1, action2, nil]];
     */
}

- (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

- (void)printPoints
{
    CCLOG(@"%d points", _points.count);
    for (NSValue *value in _points) {
        CGPoint p = [value CGPointValue];
        CCLOG(@"(%.0f, %.0f)", p.x, p.y);
    }
}

- (void)changeDisplay
{
    [self updateMode];
    KaboomGameData *data = [KaboomGameData sharedData];
    if (data.mode == MODE_UNDETERMINED) {
        CCLOG(@"MODE_UNDETERMINED");
        if (data.player == PLAYER_SINGLE) {
            [self makeShow:_oneDrum1P];
            [self makeShow:_twoDrum1P];
            [self makeShow:_fourDrum1P];
        } else {
            [self makeShow:_twoDrum2P];
            [self makeShow:_fourDrum2P];
        }
    } else if (data.mode == MODE_ONE_DRUM) {
        [self makeShow:_oneDrum1P];
        [self makeDisapear:_twoDrum1P];
        [self makeDisapear:_fourDrum1P];
        
    } else if (data.mode == MODE_TWO_DRUM) {
        if (data.player == PLAYER_SINGLE) {
            [self makeDisapear:_oneDrum1P];
            [self makeShow:_twoDrum1P];
            [self makeDisapear:_fourDrum1P];
        } else {
            [self makeShow:_twoDrum2P];
            [self makeDisapear:_fourDrum2P];
        }
    } else if (data.mode == MODE_FOUR_DRUM) {
        //        CCLOG(@"MODE_FOUR_DRUM");
        if (data.player == PLAYER_SINGLE) {
            [self makeDisapear:_oneDrum1P];
            [self makeDisapear:_twoDrum1P];
            [self makeShow:_fourDrum1P];
        } else {
            [self makeDisapear:_twoDrum2P];
            [self makeShow:_fourDrum2P];
        }
    }
    [self checkDrum];
}

- (void)updateMode
{
    KaboomGameData *data = [KaboomGameData sharedData];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    if (_points.count == 0) {
        //data.mode = MODE_UNDETERMINED;
        return;
    }
    
    for (NSValue *value in _points) {
        CGPoint touchLocation = [value CGPointValue];
        CCLOG(@"location: (%.2f, %.2f)", touchLocation.x, touchLocation.y);
        
        CGRect box_d1 = CGRectMake(size.width / 2 - DETECTION_AREA_WIDTH / 2, size.height - DETECTION_AREA_HEIGHT,
                                   DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // left
        CGRect box_d2_1 = CGRectMake(0, size.height / 2 - DETECTION_AREA_HEIGHT / 2,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // right
        CGRect box_d2_2 = CGRectMake(size.width - DETECTION_AREA_WIDTH, size.height / 2- DETECTION_AREA_HEIGHT / 2,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // upper left
        CGRect box_d4_1 = CGRectMake(0, 0,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // upper right
        CGRect box_d4_2 = CGRectMake(size.width - DETECTION_AREA_WIDTH, 0,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // lower left
        CGRect box_d4_3 = CGRectMake(0, size.height - DETECTION_AREA_HEIGHT,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        // lower right
        CGRect box_d4_4 = CGRectMake(size.width - DETECTION_AREA_WIDTH, size.height - DETECTION_AREA_HEIGHT,
                                     DETECTION_AREA_WIDTH, DETECTION_AREA_HEIGHT);
        
        
        if (CGRectContainsPoint(box_d1, touchLocation) && data.player == PLAYER_SINGLE  ) {
            data.mode = MODE_ONE_DRUM;
            [_drums addObject:@(DRUM_ONE)];
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d2_1, touchLocation)) {
            data.mode = MODE_TWO_DRUM;
            [_drums addObject:@(DRUM_TWO_LEFT)];
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d2_2, touchLocation)) {
            data.mode = MODE_TWO_DRUM;
            [_drums addObject:@(DRUM_TWO_RIGHT)];
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d4_1, touchLocation)) {
            data.mode = MODE_FOUR_DRUM;
            [_drums addObject:@(DRUM_FOUR_UPPER_LEFT)];
            
            // for demo
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d4_2, touchLocation)) {
            data.mode = MODE_FOUR_DRUM;
            [_drums addObject:@(DRUM_FOUR_UPPER_RIGHT)];
            
            // for demo
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d4_3, touchLocation)) {
            data.mode = MODE_FOUR_DRUM;
            [_drums addObject:@(DRUM_FOUR_LOWER_LEFT)];
            
            // for demo
            ++self.detectCounter;
            
        } else if (CGRectContainsPoint(box_d4_4, touchLocation)) {
            data.mode = MODE_FOUR_DRUM;
            [_drums addObject:@(DRUM_FOUR_LOWER_RIGHT)];
            
            // for demo
            ++self.detectCounter;
                
        } else {
            //data.mode = MODE_UNDETERMINED;
        }
    }
}

- (void)checkDrum
{
    CCLOG(@"check drum should be back after demo");
    /*
    KaboomGameData *data = [KaboomGameData sharedData];
    if (data.mode == MODE_ONE_DRUM && [_drums containsObject:@(DRUM_ONE)]) {
        NSLog(@"DRUM = 1P_ONE");
        [self schedule:@selector(makeTransition:) interval:0.5f];
    }
    
    else if (data.mode == MODE_TWO_DRUM && [_drums containsObject:@(DRUM_TWO_LEFT)]) {//&& [_drums containsObject:@(DRUM_TWO_RIGHT)]
        NSLog(@"DRUM = 1P_TWO");
        [self schedule:@selector(makeTransition:) interval:0.5f];
    }
    
    else if (data.mode == MODE_FOUR_DRUM && [_drums containsObject:@(DRUM_FOUR_UPPER_LEFT)] && [_drums containsObject:@(DRUM_FOUR_UPPER_RIGHT)] &&
             [_drums containsObject:@(DRUM_FOUR_LOWER_LEFT)] && [_drums containsObject:@(DRUM_FOUR_LOWER_RIGHT)]) {
        NSLog(@"DRUM = 1P_FOUR");
        [self schedule:@selector(makeTransition:) interval:0.5f];
    }
    */
}

-(void) makeTransition:(ccTime)dt
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.4 scene:[DrumSelectionLayer scene] withColor:ccWHITE]];
    [self unschedule:@selector(makeTransition:)];
}

@end
