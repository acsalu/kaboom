//
//  TouchTracker.h
//  Kaboom
//
//  Created by LCR on 4/17/13.
//
//

#import <Foundation/Foundation.h>

typedef struct
{
    int drumIdx;
    void *touchPtr;
} TouchTrack;

@interface TouchTracker : NSObject

@property (assign, nonatomic) TouchTrack *touchTracks;

+ (TouchTracker *)sharedTouchTracker;
- (int)getTouchID:(void *)touch;
- (int)addNewTouch:(void *)touch withDrumIndex:(int)drumIndex;
- (void)clearAllTracks;

@end
