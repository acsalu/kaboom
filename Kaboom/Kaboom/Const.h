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

+ (NSArray *)getDrumHitRects;
+ (CGPoint)basePointForDrum:(int)drumId;
+ (NSArray *)getAllDrumBasePoints;
+ (int)playerIdForDrum:(int)drumId;

@end