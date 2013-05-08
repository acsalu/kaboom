//
//  Const.m
//  Kaboom
//
//  Created by Acsa Lu on 4/11/13.
//
//

#import "Const.h"
#import "KaboomGameData.h"
#import "cocos2d.h"


#define kDrumHitRectOffsetX 0
#define kDrumHitRectOffsetY 0
#define kDrumHitRectWidth 130
#define kDrumHitRectHeight 130

const int TouchPriorityDrumSprite         = -50;
const int TouchPriorityDrumLayer          = -40;
const int TouchPriorityDrumEffectSprite   = -10;
const int TouchPriorityDrumSelectionLayer = 0;
const int TouchPriorityStartButton        = 10;

NSString * const DrumKey_ONE            = @"DrumKey_ONE";
NSString * const DrumKey_LEFT           = @"DrumKey_LEFT";
NSString * const DrumKey_RIGHT          = @"DrumKey_RIGHT";
NSString * const DrumKey_LEFT_TOP       = @"DrumKey_LEFT_TOP";
NSString * const DrumKey_RIGHT_TOP      = @"DrumKey_RIGHT_TOP";
NSString * const DrumKey_RIGHT_BOTTOM   = @"DrumKey_RIGHT_BOTTOM";
NSString * const DrumKey_LEFT_BOTTOM    = @"DrumKey_LEFT_BOTTOM";


@implementation Const

+ (NSArray *) getDrumHitRects
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSArray *result = nil;
    KaboomGameData *data = [KaboomGameData sharedData];
    
    
    if (data.mode == MODE_ONE_DRUM) {
        CGRect drum1 = CGRectMake(size.width / 2 - kDrumHitRectWidth, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY,
                                  kDrumHitRectWidth, kDrumHitRectHeight);
        result = @[[NSValue valueWithCGRect:drum1]];
        
    } else if (data.mode == MODE_TWO_DRUM) {
        CGRect drum2_left = CGRectMake(kDrumHitRectOffsetX, size.height / 2 - kDrumHitRectHeight, kDrumHitRectWidth, kDrumHitRectHeight);
        CGRect drum2_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, size.height / 2 -  kDrumHitRectHeight, kDrumHitRectWidth, kDrumHitRectHeight);
        result = @[[NSValue valueWithCGRect:drum2_left], [NSValue valueWithCGRect:drum2_right]];
        
    } else {
        CGRect drum4_upper_left = CGRectMake(kDrumHitRectOffsetX, kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_upper_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_lower_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY,
                                              kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_lower_left = CGRectMake(kDrumHitRectOffsetX, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        result = @[[NSValue valueWithCGRect:drum4_upper_left], [NSValue valueWithCGRect:drum4_upper_right], [NSValue valueWithCGRect:drum4_lower_right], [NSValue valueWithCGRect:drum4_lower_left]];
    }
    
    return result;
}

+ (CGPoint)basePointForDrum:(int)drumId
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    KaboomGameData *data = [KaboomGameData sharedData];
    
    
    if (data.mode == MODE_ONE_DRUM) {
        return ccp(size.width / 2, 0);
        
    } else if (data.mode == MODE_TWO_DRUM) {
        if (drumId == 0) return ccp(0, size.height / 2);
        return ccp(size.width, size.height / 2);
        
    } else {
        switch (drumId) {
            case 0: return ccp(0, size.height);
            case 1: return ccp(size.width, size.height);
            case 2: return ccp(size.width, 0);
            case 3: return ccp(0, 0);
        }
    }
    
    return ccp(-1, -1);
}

+ (NSArray *)getAllDrumBasePoints
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    KaboomGameData *data = [KaboomGameData sharedData];
    
    if (data.mode == MODE_ONE_DRUM) {
        return [NSArray arrayWithObject:[NSValue valueWithCGPoint:ccp(size.width / 2, 0)]];
        
    } else if (data.mode == MODE_TWO_DRUM) {
        return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:ccp(0, size.height / 2)],
                                         [NSValue valueWithCGPoint:ccp(size.width, size.height / 2)],
                                         nil];
    
    } else {
        return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:ccp(0, size.height)],
                                         [NSValue valueWithCGPoint:ccp(size.width, size.height)],
                                         [NSValue valueWithCGPoint:ccp(size.width, 0)],
                                         [NSValue valueWithCGPoint:ccp(0, 0)],
                                         nil];
    
    }
    
    return nil;
}

+ (int)playerIdForDrum:(int)drumId
{
    CCLOG(@"drumId %d", drumId);
    KaboomGameData *data = [KaboomGameData sharedData];
    if (data.player == PLAYER_SINGLE) return 0;
    if (data.mode == MODE_TWO_DRUM) {
        if (drumId == 0) return 0;
        else return 1;
    } else {
        if (drumId == 0 || drumId == 3) return 0;
        else return 1;
    }
    return -1;
}

@end
