//
//  KaboomGameData.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum mode {
    MODE_UNDETERMINED = 0,
    MODE_ONE_DRUM = 1,
    MODE_TWO_DRUM = 2,
    MODE_FOUR_DRUM = 4
};

enum player {
    PLAYER_SINGLE,
    PLAYER_TWO
};

typedef enum mode MODE;
typedef enum player PLAYER;

@interface KaboomGameData : NSObject

+ (KaboomGameData *)sharedData;
- (CCSprite *)drumSprite;
- (BOOL) allDrumsAreSet;

@property (nonatomic) MODE mode;
@property (nonatomic) PLAYER player;
@property (strong, nonatomic) NSMutableDictionary *drumEffect;


@end
