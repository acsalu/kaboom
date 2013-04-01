//
//  DrumSelectionLayer.m
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "DrumSelectionLayer.h"

@implementation DrumSelectionLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DrumSelectionLayer *layer = [DrumSelectionLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background;
        CGPoint center = ccp(size.width/2, size.height/2);
        
//        CCMenuItem *startMenuItem = [CCMenuItemImage itemWithNormalImage:<#(NSString *)#> selectedImage:<#(NSString *)#> block:<#^(id sender)block#>];
        
        background = [CCSprite spriteWithFile:@"drum-selection.png"];
        background.position = center;
       
        [self addChild:background];
	}
	return self;
}

@end
