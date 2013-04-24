//
//  TouchTracker.m
//  Kaboom
//
//  Created by LCR on 4/17/13.
//
//

#import "TouchTracker.h"

static const int MAX_TOUCH_POINTS = 11;

@implementation TouchTracker

+ (TouchTracker *)sharedTouchTracker
{
    static dispatch_once_t once;
    static TouchTracker *sharedTouchTracker;
    dispatch_once(&once, ^ {
        sharedTouchTracker = [[self alloc] init];
    });
    return sharedTouchTracker;
}

- (id)init
{
    if (self = [super init]) {
        _touchTracks = malloc(sizeof(TouchTrack) * MAX_TOUCH_POINTS);
    }
    [self clearAllTracks];
    return self;
}

- (int)getTouchID:(void *)touch
{
    for (int i=0; i<MAX_TOUCH_POINTS; i++) {
        if (self.touchTracks[i].touchPtr == touch) {
            return i;
        }
    }
    return -1;
}

- (int)addNewTouch:(void *)touch withDrumIndex:(int)drumIndex
{
    for (int i=0; i<MAX_TOUCH_POINTS; i++) {
        if (!self.touchTracks[i].touchPtr) {
            self.touchTracks[i].touchPtr = touch;
            self.touchTracks[i].drumIdx = drumIndex;
            return i;
        }
    }
    return -1;
}

- (void)clearAllTracks
{
    TouchTrack defaultTrack = {0, 0};
    for (int i=0; i<MAX_TOUCH_POINTS; i++) {
        self.touchTracks[i] = defaultTrack;
    }
}

@end
