//
//  DrumSelectionLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "cocos2d.h"

@interface DrumSelectionLayer : CCLayer

@property (strong, nonatomic) NSArray *drums;
@property (strong, nonatomic) NSArray *initialLocations;
@property (nonatomic) int currentDrum;


+(CCScene *) scene;

@end
