//
//  ShowResultLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/24/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShowResultLayer.h"
#import "SongSelectionLayer.h"
#import "KaboomGameData.h"
#import "Utility.h"

@implementation ShowResultLayer

+ (CCLayer *)showResultLayerWithScore:(NSMutableArray *)score andTotalNotes:(int)totalNotes
{
    KaboomGameData *data = [KaboomGameData sharedData];
    ShowResultLayer *layer = [ShowResultLayer node];
    
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint center = ccp(size.width/2, size.height/2);
    
    CCSprite *resultBack = [CCSprite spriteWithFile:@"resultback.png"];
    resultBack.position = center;
    [layer addChild:resultBack];

    CCMenuItem *backToMainItem = [CCMenuItemImage itemWithNormalImage:@"backtomain.png" selectedImage:@"backtomainp.png" block:^(id sender) {
        NSLog(@"Back to song selcetion layer");
        [[CCDirector sharedDirector] replaceScene:[SongSelectionLayer scene]];
    }];
    CCMenu *backMenu = [CCMenu menuWithItems:backToMainItem, nil];
    backMenu.position = ccp(size.width/2 - 17.5, size.height/2);
    [layer addChild:backMenu];
    
    Rank rank_1p = [Utility calculateRank:[score[0] integerValue] totalNotes:totalNotes];
    
    CCSprite *star_1p[3];
    for (int i=0; i<3; i++) {
        star_1p[i] = [CCSprite spriteWithFile:@"star.png"];
        [layer addChild:star_1p[i]];
    }
    star_1p[0].position = ccp(center.x - 110, center.y - 150);
    star_1p[1].position = ccp(center.x, center.y - 175);
    star_1p[2].position = ccp(center.x + 110, center.y - 150);
    
    if (rank_1p & TWO_STAR) {
        star_1p[2].visible = NO;
    } else if (rank_1p & ONE_STAR) {
        star_1p[1].visible = star_1p[2].visible = NO;
    } else if (rank_1p & ZERO_STAR) {
        star_1p[0].visible = star_1p[1].visible = star_1p[2].visible = NO;
    }
    
    if (data.player == PLAYER_TWO) {
        Rank rank_2p = [Utility calculateRank:[score[1] integerValue] totalNotes:totalNotes];
        CCSprite *star_2p[3];
        for (int i=0; i<3; i++) {
            star_2p[i] = [CCSprite spriteWithFile:@"star.png"];
            [layer addChild:star_2p[i]];
        }
        star_2p[0].position = ccp(center.x + 110, center.y + 150);
        star_2p[1].position = ccp(center.x, center.y + 175);
        star_2p[2].position = ccp(center.x - 110, center.y + 150);
        
        if (rank_2p & TWO_STAR) {
            star_2p[2].visible = NO;
        } else if (rank_2p & ONE_STAR) {
            star_2p[1].visible = star_2p[2].visible = NO;
        } else if (rank_2p & ZERO_STAR) {
            star_2p[0].visible = star_2p[1].visible = star_2p[2].visible = NO;
        }
    }
    
    
    
    return layer;
}

@end
