//
//  DrumLayer.h
//  Kaboom
//
//  Created by LCR on 5/8/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DrumLayer : CCLayer <CCTargetedTouchDelegate>

@property (strong, nonatomic) NSArray *hitRects;
@property (strong, nonatomic) NSMutableArray *noteQueue;

@end
