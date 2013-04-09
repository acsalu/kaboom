//
//  SongSelectionLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "SongSelectionLayer.h"
#import "GameLayer.h"

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
        
        background = [CCSprite spriteWithFile:@"drum-selection.png"];
        background.position = center;
        
        CCMenuItem *song = [CCMenuItemImage itemWithNormalImage:@"list1.png" selectedImage:@"list1.png" block:^(id sender) {
            NSLog(@"song is chosen!");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.0f scene:[GameLayer scene]]];
        }];
        
        CCMenu *songMenu = [CCMenu menuWithArray:@[song]];
        
        [self addChild:background];
        [self addChild:songMenu];
	}
	return self;
}


@end
