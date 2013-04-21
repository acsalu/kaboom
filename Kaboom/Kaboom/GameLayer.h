//
//  GameLayer.h
//  Kaboom
//
//  Created by Acsa Lu on 4/9/13.
//
//

#import "cocos2d.h";

@interface GameLayer : CCLayer

+(CCScene *) scene;

@property (strong, nonatomic) NSArray *hitRects;
@property (nonatomic) int count;
@property (strong, nonatomic) CCSprite *countdownSprite;

@end
