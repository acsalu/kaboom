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
    MODE_UNDETERMINED,
    MODE_ONE_DRUM,
    MODE_TWO_DRUM,
    MODE_FOUR_DRUM
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

@property (nonatomic) MODE mode;
@property (nonatomic) PLAYER player;
@property (strong, nonatomic) NSMutableDictionary *drumEffect;


@end
