//
//  GESoundManager.h
//  gene_SoundManager
//
//  Created by LCR on 12/10/12.
//  Copyright (c) 2012 LCR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "cocos2d.h"
#import "Const.h"
#import "DrumSelectionLayer.h"

//@protocol GESoundRecorderDelegate <NSObject>
//
//@required
//
//
//@end

static int recordCount;

@interface GESoundManager : CCLayer <AVAudioPlayerDelegate, AVAudioRecorderDelegate>
{
//    AVAudioPlayer *audioPlayer;
    CCSprite* recordSprite;
}

@property (weak, nonatomic) CCLayer *delegate;

//@property (strong, nonatomic) CCLayer *recordLayer;

@property (nonatomic) int count;
@property (strong, nonatomic) CCSprite *countdownSprite;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (nonatomic) BOOL playing;

+ (GESoundManager *)soleSoundManager;
- (void)playEffect:(NSString *)fileName;

- (void)openRecordLayerForDrum:(NSString *)drumKey;


@end
