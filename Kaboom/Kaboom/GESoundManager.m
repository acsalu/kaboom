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
        recordCount = 0;
        
        [self createRecordLayer];
        

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
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:fileName];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _audioPlayer.delegate = self;
    [_audioPlayer play];
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
    _audioPlayer = nil;
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
    recordCount++;
    [[[KaboomGameData sharedData] drumEffect] setObject:[NSString stringWithFormat:@"d6-%d.wav", recordCount] forKey:drumKey];
}

- (void)countdown:(ccTime)delta{
    if (_count < 0) {
        [self removeChild:_countdownSprite cleanup:YES];
        [self unschedule:@selector(countdown:)];
        _count = 1;
        [self record];
//        [self schedule:@selector(record:) interval:delta];
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
- (void)record
{
    NSString *recordFileName = [NSString stringWithFormat:@"d6-%d.wav", recordCount];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);;
    NSString *docsDir = dirPaths[0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:recordFileName];
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
    
    
    
    if (error){
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [_audioRecorder prepareToRecord];
    }
    
    

    if (!_audioRecorder.recording){
        NSLog(@"record");
//        [_audioRecorder recordForDuration:(NSTimeInterval) 1];
        [_audioRecorder record];
        [_audioRecorder performSelector:@selector(stop) withObject:nil afterDelay:1.0];
    }



}


-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"Record OK!!! URL: %@", _audioRecorder.url);
    _audioRecorder = nil;
    
    _delegate.isTouchEnabled = YES;
//    [self playEffect:recordFileName];
    [recordSprite runAction:[CCPlace actionWithPosition:ccp([CCDirector sharedDirector].winSize.width/2 ,
                                                            [CCDirector sharedDirector].winSize.height + 700)]];
    [_delegate removeChild:self cleanup:YES];
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode Error occurred");
}



@end
