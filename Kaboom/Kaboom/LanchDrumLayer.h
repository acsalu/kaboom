//
//  LanchDrumLayer.h
//  Kaboom
//
//  Created by LCR on 5/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    LandScape,
    Portrait
} ORIENTATION;

@interface LanchDrumLayer : CCLayer
{
    ORIENTATION orientation;
}

@property (strong, nonatomic) NSArray *drums;

- (void)changeOrientation;

@end
