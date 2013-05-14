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
        CGRect drum1 = CGRectMake(size.width / 2 - kDrumHitRectWidth / 2, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY,
                                  kDrumHitRectWidth, kDrumHitRectHeight);
        result = @[[NSValue valueWithCGRect:drum1]];
        
    } else if (data.mode == MODE_TWO_DRUM) {
        CGRect drum2_left = CGRectMake(kDrumHitRectOffsetX, size.height / 2 - kDrumHitRectHeight / 2, kDrumHitRectWidth, kDrumHitRectHeight);
        CGRect drum2_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, size.height / 2 -  kDrumHitRectHeight / 2, kDrumHitRectWidth, kDrumHitRectHeight);
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

+ (NSArray *)getAllPossibleBasePoints
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    return [NSArray arrayWithObjects:[NSValue valueWithCGPoint:ccp(size.width / 2, 0)],
                                     [NSValue valueWithCGPoint:ccp(0, size.height / 2)],
                                     [NSValue valueWithCGPoint:ccp(size.width, size.height / 2)],
                                     [NSValue valueWithCGPoint:ccp(0, size.height)],
                                     [NSValue valueWithCGPoint:ccp(size.width, size.height)],
                                     [NSValue valueWithCGPoint:ccp(size.width, 0)],
                                     [NSValue valueWithCGPoint:ccp(0, 0)],
                                     nil];
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

+ (CGPoint)startingPointWithNoteType:(NoteType)type
{
    CGPoint startingPoint;
    CGSize size = [CCDirector sharedDirector].winSize;
    switch (type) {
        case NOTE_TYPE_IN0:
        case NOTE_TYPE_IN1:
        case NOTE_TYPE_IN2:
        case NOTE_TYPE_IN3:
            startingPoint = ccp(size.width / 2, size.height / 2);
            break;
        case NOTE_TYPE_P_AB:
        case NOTE_TYPE_P_AF:
            startingPoint = ccp(size.width * 0.07, size.height * 0.93);
            break;
        case NOTE_TYPE_P_BA:
        case NOTE_TYPE_P_BC:
            startingPoint = ccp(size.width / 2, size.height * 0.93);
            break;
        case NOTE_TYPE_P_CB:
        case NOTE_TYPE_P_CD:
            startingPoint = ccp(size.width * 0.93, size.height * 0.93);
            break;
        case NOTE_TYPE_P_DC:
        case NOTE_TYPE_P_DE:
            startingPoint = ccp(size.width * 0.93, size.height * 0.07);
            break;
        case NOTE_TYPE_P_ED:
        case NOTE_TYPE_P_EF:
            startingPoint = ccp(size.width / 2, size.height * 0.07);
            break;
        case NOTE_TYPE_P_FA:
        case NOTE_TYPE_P_FE:
            startingPoint = ccp(size.width * 0.07, size.height * 0.07);
            
        default:
            break;
    }
    return startingPoint;
}

+ (CGPoint)destinationPointWithNoteType:(NoteType)type
{
    CGPoint destinationPoint;
    CGSize size = [CCDirector sharedDirector].winSize;
    switch (type) {
        case NOTE_TYPE_IN0:
        case NOTE_TYPE_P_FA:
        case NOTE_TYPE_P_BA:
            destinationPoint = ccp(size.width * 0.07, size.height * 0.93);
            break;
        
        case NOTE_TYPE_P_AB:
        case NOTE_TYPE_P_CB:
            destinationPoint = ccp(size.width / 2, size.height * 0.93);
            break;
        
        case NOTE_TYPE_IN1:
        case NOTE_TYPE_P_BC:
        case NOTE_TYPE_P_DC:
            destinationPoint = ccp(size.width * 0.93, size.height * 0.93);
            break;
        
        case NOTE_TYPE_IN2:
        case NOTE_TYPE_P_CD:
        case NOTE_TYPE_P_ED:
            destinationPoint = ccp(size.width * 0.93, size.height * 0.07);
            break;
        
        case NOTE_TYPE_P_DE:
        case NOTE_TYPE_P_FE:
            destinationPoint = ccp(size.width / 2, size.height * 0.07);
            break;
        
        case NOTE_TYPE_IN3:
        case NOTE_TYPE_P_AF:
        case NOTE_TYPE_P_EF:
            destinationPoint = ccp(size.width * 0.07, size.height * 0.07);
            break;
            
            
        default:
            break;
    }
    return destinationPoint;
}

+ (NSString *)drumKeyPointWithNoteType:(NoteType)type
{
    NSString *drumKey = nil;
    switch (type) {
        case NOTE_TYPE_IN0:
        case NOTE_TYPE_P_BA:
        case NOTE_TYPE_P_FA:
            drumKey = DrumKey_LEFT_TOP;
            break;
        case NOTE_TYPE_IN1:
        case NOTE_TYPE_P_BC:
        case NOTE_TYPE_P_DC:
            drumKey = DrumKey_RIGHT_TOP;
            break;
        case NOTE_TYPE_IN2:
        case NOTE_TYPE_P_CD:
        case NOTE_TYPE_P_ED:
            drumKey = DrumKey_RIGHT_BOTTOM;
            break;
        case NOTE_TYPE_IN3:
        case NOTE_TYPE_P_EF:
        case NOTE_TYPE_P_AF:
            drumKey = DrumKey_LEFT_BOTTOM;
            break;
            
        default:
            break;
    }
    return drumKey;

}

+ (CGFloat)rotationWithNoteType:(NoteType)type
{
    CGFloat rotation = 0;
    switch (type) {
        case NOTE_TYPE_P_AB:
        case NOTE_TYPE_P_BC:
        case NOTE_TYPE_P_ED:
        case NOTE_TYPE_P_FE:
            rotation = 90;
            break;
        case NOTE_TYPE_P_CB:
        case NOTE_TYPE_P_BA:
        case NOTE_TYPE_P_DE:
        case NOTE_TYPE_P_EF:
            rotation = -90;
            break;
        case NOTE_TYPE_P_CD:
        case NOTE_TYPE_P_AF:
            rotation = 180;
            break;
        default:
            break;
    }
    
    return rotation;
}

@end
