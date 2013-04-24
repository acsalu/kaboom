//
//  Utility.h
//  Kaboom
//
//  Created by LCR on 4/24/13.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    ZERO_STAR = 1,
    ONE_STAR = 2,
    TWO_STAR = 4,
    THREE_STAR = 8
} Rank;


@interface Utility : NSObject

+ (Rank)calculateRank:(int)score totalNotes:(int)total;

@end
