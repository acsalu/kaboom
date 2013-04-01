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
    static dispatch_once_t onceToken;
    __strong static id __data = nil;
    dispatch_once(&onceToken, ^{
        __data = [[KaboomGameData alloc] init];
        [__data setMode:MODE_UNDETERMINED];
    });
    return __data;
}

@end
