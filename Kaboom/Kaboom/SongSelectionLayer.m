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

-(CCLayer*) layerWithLevelName:(NSString*)name number:(int)number screenSize:(CGSize)screenSize
{
    CCLayer *layer = [[CCLayer alloc] init];
    
    //int largeFont = [CCDirector sharedDirector].winSize.height / 9;
    //CCLabelTTF *image =  [CCLabelTTF labelWithString:name fontName:@"Marker Felt" fontSize:largeFont];
    
    CCSprite *image = [CCSprite spriteWithFile:name];
    //image.position =  ccp( screenSize.width / 2 , screenSize.height / 2 + 10 );
    [layer addChild:image];
    
    return layer;
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
        
//        CCMenuItem *song = [CCMenuItemImage itemWithNormalImage:@"list1.png" selectedImage:@"list1.png" block:^(id sender) {
//            NSLog(@"song is chosen!");
//            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.0f scene:[GameLayer scene]]];
//        }];
//        
//        
//        CCMenu *songMenu = [CCMenu menuWithArray:@[song]];
        
        
        [self addChild:background];
//        [self addChild:songMenu];
        [self addChild:drum];
        
        
        NSMutableArray* _layers = [[NSMutableArray alloc] init];
        
        for (int i=0; i<5; i++)
        {
            int number = i;
            NSString* name = [NSString stringWithFormat:@"song%d_ipad.png",i+1];
            CCLayer* layer = [self layerWithLevelName:name number:number screenSize:size];
            
            [_layers addObject:layer];
        }
        
        //FGScrollLayer *scroller = [[FGScrollLayer alloc] initWithLayers:_layers widthOffset:100];
        
        CGRect rect = CGRectMake(size.width/2, 100, 100, 300);
        CGSize smallsize = CGSizeMake(size.width/2, size.height/3);
        
        FGScrollLayer *scroller = [[FGScrollLayer alloc] initWithLayers:_layers pageSize:smallsize pagesOffset:100 visibleRect:rect];
        //[scroller selectPage:0];
        
        [self addChild:scroller];

	}
	return self;
}


@end
