//
//  KaboomGameData.m
//  Kaboom
//
//  Created by Acsa Lu on 4/1/13.
//
//

#import "KaboomGameData.h"

@implementation KaboomGameData

+ (KaboomGameData *)sharedData
{
    static KaboomGameData *sharedData;
    @synchronized(self) {
        if (!sharedData) {
            NSLog(@"new instance is created");
            sharedData = [[self alloc] init];
        }
    }
    return sharedData;
}


- (id)init
{
    if (self = ([super init])) {
        
        _drumEffect = [NSMutableDictionary dictionary];
        _player = PLAYER_SINGLE;
    }
    
    return self;
}

- (CCSprite *) drumSprite {
    NSString *imageName = nil;
    if (_player == PLAYER_SINGLE) {
        if (_mode == MODE_ONE_DRUM) imageName = @"1p1d.png";
        else if (_mode == MODE_TWO_DRUM) imageName = @"1p2d.png";
        else imageName = @"1p4d.png";
    } else {
        if (_mode == MODE_TWO_DRUM) imageName = @"2p2d.png";
        else imageName = @"2p4d.png";
    }
    
    CCSprite *drum = [CCSprite spriteWithFile:imageName];
    CGPoint position = ccp(512, 384);
    drum.position = position;
    
    return drum;
}

- (BOOL)allDrumsAreSet {
    if (self.mode == MODE_UNDETERMINED) {
        return NO;
    } else if (self.mode == [self.drumEffect count]) {
        return YES;
    } else {
        return NO;
    }
}

@end
