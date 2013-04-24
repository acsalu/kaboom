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
    if (percent >= 0.9) {
        return THREE_STAR;
    } else if (percent >= 0.7) {
        return TWO_STAR;
    } else if (percent >= 0.25) {
        return ONE_STAR;
    } else {
        return ZERO_STAR;
    }
}

@end
