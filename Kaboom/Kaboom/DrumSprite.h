//
//  DrumSprite.h
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DrumSprite : CCSprite <CCTargetedTouchDelegate>

@property (strong, nonatomic) NSValue *hitRect;
@property (strong, nonatomic) NSString *effectKey;
@property (strong, nonatomic) NSMutableDictionary *effectDict;

@end
