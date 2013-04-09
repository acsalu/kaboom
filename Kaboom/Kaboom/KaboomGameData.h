//
//  KaboomGameData.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import <Foundation/Foundation.h>

enum MODE {
    MODE_UNDETERMINED,
    MODE_SINGLE_ONE,
    MODE_SINGLE_TWO,
    MODE_SINGLE_FOUR
};

typedef enum MODE MODE;

@interface KaboomGameData : NSObject

+ (KaboomGameData *)sharedData;

@property (nonatomic) MODE mode;
@property (strong, nonatomic) NSMutableDictionary *drumEffect;

@end
