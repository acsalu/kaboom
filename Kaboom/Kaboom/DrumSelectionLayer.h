//
//  DrumSelectionLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "cocos2d.h"
#import "TouchTracker.h"
#import <AVFoundation/AVFoundation.h>
#import "GESoundManager.h"

@interface DrumSelectionLayer : CCLayer
{
    // record

}

@property (strong, nonatomic) NSArray *drums;
@property (strong, nonatomic) NSArray *initialLocations;
@property (strong, nonatomic) NSMutableArray *draggedDrums;
@property (nonatomic) int currentDrum;

@property (strong, nonatomic) TouchTracker *sharedTouchTracker;

// record
//


+(CCScene *) scene;

@end
