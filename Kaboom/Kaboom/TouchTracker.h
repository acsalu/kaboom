//
//  TouchTracker.h
//  Kaboom
//
//  Created by LCR on 4/17/13.
//
//

#import <Foundation/Foundation.h>

#define MAX_TOUCH_POINTS 11

typedef struct
{
    int drumIdx;
    void *touchPtr;
} TouchTrack;

TouchTrack touchTracker[MAX_TOUCH_POINTS];

int getTouchID(void* touch);
int addNewTouch(void* touch, int drumIdx);

@interface TouchTracker : NSObject


@end
