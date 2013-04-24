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

+ (CGPoint)basePointForDrum:(int)drumId
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    KaboomGameData *data = [KaboomGameData sharedData];
    
    
    if (data.mode == MODE_ONE_DRUM) {
        return ccp(size.width / 2, 0);
        
    } else if (data.mode == MODE_TWO_DRUM) {
        if (drumId == 0) return ccp(0, size.height / 2);
        return ccp(size.width, size.height / 2);
        
    } else {
        switch (drumId) {
            case 0: return ccp(0, size.height);
            case 1: return ccp(size.width, size.height);
            case 2: return ccp(size.width, 0);
            case 3: return ccp(0, 0);
        }
    }
    
    return ccp(-1, -1);
}

+ (int)playerIdForDrum:(int)drumId
{
    CCLOG(@"drumId %d", drumId);
    KaboomGameData *data = [KaboomGameData sharedData];
    if (data.player == PLAYER_SINGLE) return 0;
    if (data.mode == MODE_TWO_DRUM) {
        if (drumId == 0) return 0;
        else return 1;
    } else {
        if (drumId == 0 || drumId == 3) return 0;
        else return 1;
    }
    return -1;
}

@end
