//
//  SongSelectionLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "SongSelectionLayer.h"
#import "GameLayer.h"
#import "KaboomGameData.h"

@implementation SongSelectionLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SongSelectionLayer *layer = [SongSelectionLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        CCSprite *background = (data.player == PLAYER_SINGLE) ? [CCSprite spriteWithFile:@"background2-landscape.png"] : [CCSprite spriteWithFile:@"background2-portrait.png"];
        background.position = ccp(size.width * 1 / 2, size.height / 2);
        
        CCSprite *drum = [data drumSprite];
        
        CCMenuItem *song = [CCMenuItemImage itemWithNormalImage:@"song1.png" selectedImage:@"song1.png" block:^(id sender) {
            NSLog(@"song is chosen!");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.0f scene:[GameLayer scene]]];
        }];
        
        
        CCMenu *songMenu = [CCMenu menuWithArray:@[song]];
        songMenu.position = ccp(size.width / 2, size.height / 2);
        if (data.player == PLAYER_TWO) song.rotation = 90;
        
        [self addChild:background];
        [self addChild:drum];
        [self addChild:songMenu];
	}
	return self;
}


@end
