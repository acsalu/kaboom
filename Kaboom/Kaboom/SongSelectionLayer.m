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
        
        CCSprite *background;
        CGPoint center = ccp(size.width/2, size.height/2);
        
        background = [CCSprite spriteWithFile:@"1-00.png"];
        background.position = center;
        
        KaboomGameData *data = [KaboomGameData sharedData];
        
        CCSprite *drum = [data drumSprite];
        
        CCMenuItem *song = [CCMenuItemImage itemWithNormalImage:@"list1.png" selectedImage:@"list1.png" block:^(id sender) {
            NSLog(@"song is chosen!");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameLayer scene]]];
        }];
        
        
        CCMenu *songMenu = [CCMenu menuWithArray:@[song]];
        
        
        [self addChild:background];
        [self addChild:songMenu];
        [self addChild:drum];
	}
	return self;
}


@end
