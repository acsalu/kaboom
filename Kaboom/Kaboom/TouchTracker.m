//
//  TouchTracker.m
//  Kaboom
//
//  Created by LCR on 4/17/13.
//
//

#import "TouchTracker.h"

int getTouchID(void* touch)
{
    for (int i=0; i<MAX_TOUCH_POINTS; i++) {
        if (touchTracker[i].touchPtr == touch) {
            return i;
        }
    }
    return -1;
}

int addNewTouch(void* touch, int drumIdx)
{
    for (int i=0; i<MAX_TOUCH_POINTS; ++i) {
        if (!touchTracker[i].touchPtr) {
            touchTracker[i].touchPtr = touch;
            touchTracker[i].drumIdx = drumIdx;
            return i;
        }
    }
    return -1;
}



@implementation TouchTracker

@end
