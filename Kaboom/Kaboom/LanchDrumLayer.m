//
//  LanchDrumLayer.m
//  Kaboom
//
//  Created by LCR on 5/14/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LanchDrumLayer.h"
#import "Const.h"
#import "LauchDrumSprite.h"

@implementation LanchDrumLayer

- (id)init
{
    if (self = [super init]) {
        orientation = LandScape;
        [self addAllSprite];
        [self bumpAnimation];
        
    }
    return self;
}

- (void)bumpAnimation
{
    for (LauchDrumSprite *s in _drums) {
        [s showAnimation];
    }
}

- (void)addAllSprite
{
    NSArray *basePoints = [Const getAllPossibleBasePoints];
    
    LauchDrumSprite *d_l_0 = [LauchDrumSprite spriteWithFile:@"drum_2_4.png"];
    d_l_0.position = [basePoints[0] CGPointValue];
    LauchDrumSprite *d_l_1 = [LauchDrumSprite spriteWithFile:@"drum_2_3.png"];
    d_l_1.position = [basePoints[1] CGPointValue];
    d_l_1.rotation = 90;
    LauchDrumSprite *d_l_2 = [LauchDrumSprite spriteWithFile:@"drum_2_3.png"];
    d_l_2.position = [basePoints[2] CGPointValue];
    d_l_2.rotation = 270;
    LauchDrumSprite *d_l_3 = [LauchDrumSprite spriteWithFile:@"drum_4_2.png"];
    d_l_3.position = [basePoints[3] CGPointValue];
    d_l_3.rotation = 90;
    LauchDrumSprite *d_l_4 = [LauchDrumSprite spriteWithFile:@"drum_4_2.png"];
    d_l_4.position = [basePoints[4] CGPointValue];
    d_l_4.rotation = 180;
    LauchDrumSprite *d_l_5 = [LauchDrumSprite spriteWithFile:@"drum_4_2.png"];
    d_l_5.position = [basePoints[5] CGPointValue];
    d_l_5.rotation = 270;
    LauchDrumSprite *d_l_6 = [LauchDrumSprite spriteWithFile:@"drum_4_2.png"];
    d_l_6.position = [basePoints[6] CGPointValue];
    
    [self addChild:d_l_0];
    [self addChild:d_l_1];
    [self addChild:d_l_2];
    [self addChild:d_l_3];
    [self addChild:d_l_4];
    [self addChild:d_l_5];
    [self addChild:d_l_6];
    _drums = [NSArray arrayWithObjects:d_l_0, d_l_1, d_l_2, d_l_3, d_l_4, d_l_5, d_l_6, nil];
}

- (void)changeOrientation
{
    if (orientation == LandScape) {
        [_drums[0] setVisible:NO];
        
        CCTexture2D *texture_2_blue = [[CCTextureCache sharedTextureCache] addImage:@"drum_2_1.png"];
        [_drums[2] setTexture:texture_2_blue];
        
        CCTexture2D *texture_4_orange = [[CCTextureCache sharedTextureCache] addImage:@"drum_4_5.png"];
        [_drums[5] setTexture:texture_4_orange];
        [_drums[6] setTexture:texture_4_orange];
        
    } else if (orientation == Portrait) {
        [_drums[0] setVisible:YES];
        
        CCTexture2D *texture_2_yellow = [[CCTextureCache sharedTextureCache] addImage:@"drum_2_3.png"];
        [_drums[2] setTexture:texture_2_yellow];
        
        CCTexture2D *texture_4_red = [[CCTextureCache sharedTextureCache] addImage:@"drum_4_2.png"];
        [_drums[5] setTexture:texture_4_red];
        [_drums[6] setTexture:texture_4_red];
        
    } else {
        NSLog(@"OH!! FUCK!!");
    }
    
    [self bumpAnimation];

}

@end
