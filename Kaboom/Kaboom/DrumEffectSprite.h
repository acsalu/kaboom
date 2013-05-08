//
//  DrumEffectSprite.h
//  Kaboom
//
//  Created by LCR on 4/24/13.
//
//

#import "cocos2d.h"

@interface DrumEffectSprite : CCSprite <CCTargetedTouchDelegate>

@property (strong, nonatomic) NSMutableDictionary *touchTracks;

@end
