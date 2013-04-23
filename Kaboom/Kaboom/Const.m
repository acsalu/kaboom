//
//  Const.m
//  Kaboom
//
//  Created by Acsa Lu on 4/11/13.
//
//

#import "Const.h"
#import "KaboomGameData.h"
#import "cocos2d.h"


#define kDrumHitRectOffsetX 0
#define kDrumHitRectOffsetY 0
#define kDrumHitRectWidth 100
#define kDrumHitRectHeight 100

@implementation Const

+ (NSArray *) getDrumHitRects
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSArray *result = nil;
    KaboomGameData *data = [KaboomGameData sharedData];
    
    
    if (data.mode == MODE_ONE_DRUM) {
        CGRect drum1 = CGRectMake(size.width / 2 - kDrumHitRectWidth, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY,
                                  kDrumHitRectWidth, kDrumHitRectHeight);
        result = @[[NSValue valueWithCGRect:drum1]];
        
    } else if (data.mode == MODE_TWO_DRUM) {
        CGRect drum2_left = CGRectMake(kDrumHitRectOffsetX, size.height / 2 - kDrumHitRectHeight, kDrumHitRectWidth, kDrumHitRectHeight);
        CGRect drum2_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, size.height / 2 -  kDrumHitRectHeight, kDrumHitRectWidth, kDrumHitRectHeight);
        result = @[[NSValue valueWithCGRect:drum2_left], [NSValue valueWithCGRect:drum2_right]];
        
    } else {
        CGRect drum4_upper_left = CGRectMake(kDrumHitRectOffsetX, kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_upper_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_lower_right = CGRectMake(size.width - kDrumHitRectWidth - kDrumHitRectOffsetX, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY,
                                              kDrumHitRectWidth, kDrumHitRectHeight);
        
        CGRect drum4_lower_left = CGRectMake(kDrumHitRectOffsetX, size.height - kDrumHitRectHeight - kDrumHitRectOffsetY, kDrumHitRectWidth, kDrumHitRectHeight);
        
        result = @[[NSValue valueWithCGRect:drum4_upper_left], [NSValue valueWithCGRect:drum4_upper_right], [NSValue valueWithCGRect:drum4_lower_right], [NSValue valueWithCGRect:drum4_lower_left]];
    }
    
    return result;
}

@end
