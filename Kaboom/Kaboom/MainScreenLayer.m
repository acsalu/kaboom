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

#define DETECTION_AREA_WIDTH 40
#define DETECTION_AREA_HEIGHT 40

@implementation MainScreenLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScreenLayer *layer = [MainScreenLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        _points = [NSMutableArray array];
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        CGPoint center = ccp(size.width/2, size.height/2);

        background = [CCSprite spriteWithFile:@"main-screen-single.png"];
        background.position = center;
        
        _oneDrum = [CCSprite spriteWithFile:@"1p1d.png"];
        _oneDrum.position = center;
        
        _twoDrum = [CCSprite spriteWithFile:@"1p2d.png"];
        _twoDrum.position = center;
        
        _fourDrum = [CCSprite spriteWithFile:@"1p4d.png"];
        _fourDrum.position = center;
        
        [self addChild: background];
        [self addChild: _oneDrum];
        [self addChild: _twoDrum];
        [self addChild: _fourDrum];
	}
	return self;
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
    [self printPoints];
    [self changeDisplay];
}

- (void)makeDisapear:(CCNode *)node
{
    node.visible = NO;
    /*
    if (!node.visible) return;
    CCAction *action1 = [CCFadeOut actionWithDuration:0.3];
    CCAction *action2 = [CCHide action];
    [node runAction:[CCSequence actions:action1, action2, nil]];
    */
}

- (void)makeShow:(CCNode *)node
{
    node.visible = YES;
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
    switch(data.mode) {
        case MODE_UNDETERMINED:
            CCLOG(@"MODE_UNDETERMINED");
            [self makeShow:_oneDrum];
            [self makeShow:_twoDrum];
            [self makeShow:_fourDrum];
            break;
        case MODE_SINGLE_ONE:
            CCLOG(@"MODE_SINGLE_ONE");
            [self makeShow:_oneDrum];
            [self makeDisapear:_twoDrum];
            [self makeDisapear:_fourDrum];
            break;
        case MODE_SINGLE_TWO:
            CCLOG(@"MODE_SINGLE_TWO");
            [self makeDisapear:_oneDrum];
            [self makeShow:_twoDrum];
            [self makeDisapear:_fourDrum];
            break;
        case MODE_SINGLE_FOUR:
            CCLOG(@"MODE_SINGLE_FOUR");
            [self makeDisapear:_oneDrum];
            [self makeDisapear:_twoDrum];
            [self makeShow:_fourDrum];
            break;
    }
}

- (void)updateMode
{
    KaboomGameData *data = [KaboomGameData sharedData];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCDirector* director = [CCDirector sharedDirector];
    
    if (_points.count == 0) {
        data.mode = MODE_UNDETERMINED;
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
        
        
        if (CGRectContainsPoint(box_d1, touchLocation)) {
            data.mode = MODE_SINGLE_ONE;
        } else if (CGRectContainsPoint(box_d2_1, touchLocation) || CGRectContainsPoint(box_d2_2, touchLocation)) {
            data.mode = MODE_SINGLE_TWO;
        } else if (CGRectContainsPoint(box_d4_1, touchLocation) || CGRectContainsPoint(box_d4_2, touchLocation) ||
                   CGRectContainsPoint(box_d4_3, touchLocation) || CGRectContainsPoint(box_d4_4, touchLocation)) {
            data.mode = MODE_SINGLE_FOUR;
        }
    }
}

@end
