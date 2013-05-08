//
//  Utility.m
//  Kaboom
//
//  Created by LCR on 4/24/13.
//
//

#import "Utility.h"

@implementation Utility

+ (Rank)calculateRank:(int)score totalNotes:(int)total
{
    float percent = (float)score / total;
    if (percent >= 0.75) {
        return THREE_STAR;
    } else if (percent >= 0.4) {
        return TWO_STAR;
    } else if (percent >= 0.15) {
        return ONE_STAR;
    } else {
        return ZERO_STAR;
    }    
}

+ (CGFloat)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat xDist = (p2.x - p1.x);
    CGFloat yDist = (p2.y - p1.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
