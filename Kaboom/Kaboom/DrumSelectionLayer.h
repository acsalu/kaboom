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

@interface DrumSelectionLayer : CCLayer <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    // record
    CCSprite* recordSprite;
}

@property (strong, nonatomic) NSArray *drums;
@property (strong, nonatomic) NSArray *initialLocations;
@property (strong, nonatomic) NSMutableArray *draggedDrums;
@property (nonatomic) int currentDrum;

@property (strong, nonatomic) TouchTracker *sharedTouchTracker;

// record
@property (nonatomic) int count;
@property (strong, nonatomic) CCSprite *countdownSprite;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
// 

+(CCScene *) scene;

@end
