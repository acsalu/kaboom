//
//  Const.h
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#define kDrumRadius 300
#define kDrumEffectiveRadius 320

#import "cocos2d.h"

extern const int TouchPriorityDrumSprite;
extern const int TouchPriorityDrumLayer;
extern const int TouchPriorityDrumEffectSprite;
extern const int TouchPriorityDrumSelectionLayer;
extern const int TouchPriorityStartButton;

extern NSString * const DrumKey_ONE;
extern NSString * const DrumKey_LEFT;
extern NSString * const DrumKey_RIGHT;
extern NSString * const DrumKey_LEFT_TOP;
extern NSString * const DrumKey_RIGHT_TOP;
extern NSString * const DrumKey_RIGHT_BOTTOM;
extern NSString * const DrumKey_LEFT_BOTTOM;

@interface Const: NSObject

enum NoteType {
    NOTE_TYPE_REST = 0,
    NOTE_TYPE_LEFT, NOTE_TYPE_RIGHT,
    NOTE_TYPE_BOUNCE_LR1, NOTE_TYPE_BOUNCE_LR2,
    NOTE_TYPE_BOUNCE_RL1, NOTE_TYPE_BOUNCE_RL2,
    NOTE_TYPE_FIRE,
    
    NOTE_TYPE_IN0, NOTE_TYPE_IN1, NOTE_TYPE_IN2, NOTE_TYPE_IN3,
    NOTE_TYPE_P_AB, NOTE_TYPE_P_BC, NOTE_TYPE_P_CD, NOTE_TYPE_P_DE, NOTE_TYPE_P_EF, NOTE_TYPE_P_FA,
    NOTE_TYPE_P_BA, NOTE_TYPE_P_CB, NOTE_TYPE_P_DC, NOTE_TYPE_P_ED, NOTE_TYPE_P_FE, NOTE_TYPE_P_AF
};

enum NoteLength {
    NOTE_LENGTH_16TH = 0,
    NOTE_LENGTH_8TH, NOTE_LENGTH_4TH, NOTE_LENGTH_2ND, NOTE_LENGTH_ALL
};

typedef enum NoteType NoteType;
typedef enum NoteLength NoteLength;

+ (NSArray *)getDrumHitRects;
+ (CGPoint)basePointForDrum:(int)drumId;
+ (NSArray *)getAllPossibleBasePoints;
+ (int)playerIdForDrum:(int)drumId;

+ (CGPoint)startingPointWithNoteType:(NoteType)type;
+ (CGPoint)destinationPointWithNoteType:(NoteType)type;
+ (NSString *)drumKeyPointWithNoteType:(NoteType)type;

@end