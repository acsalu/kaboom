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

@end
