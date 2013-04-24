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


@interface Const: NSObject

+ (NSArray *)getDrumHitRects;
+ (CGPoint)basePointForDrum:(int)drumId;
+ (int)playerIdForDrum:(int)drumId;

@end