//
//  GESoundManager.m
//  gene_SoundManager
//
//  Created by LCR on 12/10/12.
//  Copyright (c) 2012 LCR. All rights reserved.
//

#import "GESoundManager.h"
#import "KaboomGameData.h"

@implementation GESoundManager

# pragma mark -
# pragma mark Object Lifecycle

+ (GESoundManager *)soleSoundManager {
    static dispatch_once_t once;
    static GESoundManager *soleSoundManager;
    dispatch_once(&once, ^ {
        soleSoundManager = [[self alloc] init];
    });
    return soleSoundManager;
}

- (id)init {
    if ((self = [super init])) {
        // record
        NSArray *dirPaths;
        NSString *docsDir;
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"d6.wav"];
        
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                        [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0], AVSampleRateKey, nil];
        
        NSError *error = nil;
        
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL
                                                     settings:recordSettings
                                                        error:&error];
        _audioRecorder.delegate = self;
        
        
        [self createRecordLayer];
        
        if (error){
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            [_audioRecorder prepareToRecord];
        }
    }
    return self;
}

#pragma mark -
#pragma mark Interfaces

- (void)playEffect:(NSString *)fileName
{
    if (self.playing) {
        // NSLog(@"Audio player is playing.");
        return;
    }
    
    NSArray *dirPaths = dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);;
    NSString *docsDir = dirPaths[0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"d6.wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    audioPlayer.delegate = self;
    [audioPlayer play];
    self.playing = YES;
}



- (void)playAnswerOrSingleNote:(NSString *)songName instrument:(NSString *)instrument{
    if (self.playing) {
        // NSLog(@"Audio player is playing.");
        return;
    }
    
    NSString *answerFile = [[NSBundle mainBundle] pathForResource:songName ofType:@"mp3"];
    if (answerFile == nil) {
        // NSLog(@"Can't locate answer file");
        return;
    }
    NSURL *answerURL = [NSURL fileURLWithPath:answerFile];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:answerURL error:nil];
    audioPlayer.delegate = self;
    [audioPlayer play];
    self.playing = YES;
}



# pragma mark -
# pragma mark AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // NSLog(@"in Delegate");
    self.playing = NO;
    if (flag == NO) {
        // NSLog(@"Audio player decoding error.");
    }
    audioPlayer = nil;
}


////////////////////
////// record //////
////////////////////

- (void)createRecordLayer{
    
    recordSprite = [CCSprite spriteWithFile:@"pause_horizontal_ipad.png"];
    [recordSprite setPosition:ccp([CCDirector sharedDirector].winSize.width/2, [CCDirector sharedDirector].winSize.height + 700)];
//    [_delegate addChild:recordSprite z:100];
    [self addChild:recordSprite z:100];
}

- (void) openRecordLayerForDrum:(NSString *)drumKey
{
    [_delegate addChild:self];
//    [self createRecordLayer];
    // gray background
//    _delegate.isTouchEnabled = NO;
    [recordSprite runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2 ,
                                                            [CCDirector sharedDirector].winSize.height/2)]];
    
    // countdown
    float delay = 1;
    _count = 3;
    [self schedule:@selector(countdown:) interval:delay];
//    [self countdown:3];
    
//    return _recordLayer;
    [[[KaboomGameData sharedData] drumEffect] setObject:@"d6.wav" forKey:drumKey];
    
}

- (void)countdown:(ccTime)delta{
    if (_count < 0) {
        [self removeChild:_countdownSprite cleanup:YES];
        [self unschedule:@selector(countdown:)];
        _count = 1;
        [self schedule:@selector(record:) interval:delta];
    }
    else {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint center = ccp(size.width / 2, size.height / 2);
        if (_countdownSprite) [self removeChild:_countdownSprite cleanup:YES];
        _countdownSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"countdown-%d.png", _count]];
        _countdownSprite.position = center;
        [self addChild:_countdownSprite];
        --_count;
    }
}
- (void)record:(ccTime)delta{
    if (_count==1) {
        NSLog(@"record");
        if (!_audioRecorder.recording){
            [_audioRecorder recordForDuration:(NSTimeInterval) 1];
        }
        --_count;
    }
    else if(_count<0){
        [_delegate unschedule:@selector(record:)];
        _count = 1;
        [self playEffect:@"d6.wav"];
        //        [self unschedule:@selector(play:)];
        _delegate.isTouchEnabled = YES;
        [recordSprite runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2 ,
                                                                [CCDirector sharedDirector].winSize.height + 700)]];
        [_delegate removeChild:self cleanup:YES];

    }
    else{
        --_count;
    }
}


-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"Record OK!!! URL: %@", _audioRecorder.url);
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode Error occurred");
}



@end
