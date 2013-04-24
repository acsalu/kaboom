//
//  Song.m
//  Kaboom
//
//  Created by Acsa Lu on 4/22/13.
//
//

#import "Song.h"

@implementation Note

+ (Note *) noteWithType:(NoteType)type andLength:(NoteLength)length
{
    Note *note = [[Note alloc] init];
    note.type = type;
    note.length = length;
    return note;
}

@end

@implementation Song

+ (Song *) newSong
{
    Song *song = [[Song alloc] init];
    song.melody = @[
                    // 1
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 5
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 9
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_RL)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 13
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    // 17
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 22
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_RL)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 13
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    // 26
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    // 29
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    
                    // 31
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    // 33
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 37
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    // 41
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    // 44
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_RL)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 47
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_BOUNCE_LR)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    // 51
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    // 55
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    // 59
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    // 62
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_16TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    // 64
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    
                    // 65
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_CLAP)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 69
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]}
                    
                    
                    
                ];
    song.interval = 0.457;
    return song;
}

+ (NSString *)noteLengthString:(NoteLength)length
{
    switch (length) {
        case NOTE_LENGTH_16TH: return @"16th";
        case NOTE_LENGTH_8TH: return @"8th";
        case NOTE_LENGTH_4TH: return @"4th";
        case NOTE_LENGTH_2ND: return @"2nd";
        case NOTE_LENGTH_ALL: return @"all";
        default: return nil;
    }
}

+ (NSString *)noteTypeString:(NoteType)type
{
    switch (type) {
        case NOTE_TYPE_REST: return @"rest";
        case NOTE_TYPE_LEFT: return @"left";
        case NOTE_TYPE_RIGHT:return @"right";
        case NOTE_TYPE_BOUNCE_LR: return @"bounce L2R";
        case NOTE_TYPE_BOUNCE_RL: return @"bounce R2L";
        case NOTE_TYPE_CLAP: return @"clap";
        default: return nil;
    }
}

- (float)lengthInFloat:(NoteLength)length
{
    switch (length) {
        case NOTE_LENGTH_ALL: return 4 * _interval;
        case NOTE_LENGTH_2ND: return 2 * _interval;
        case NOTE_LENGTH_4TH: return _interval;
        case NOTE_LENGTH_8TH: return _interval / 2;
        case NOTE_LENGTH_16TH: return _interval / 4;
        default: return 0.0f;
    }
}

- (int)totalBeatableNotes
{
    int result = 0;
    for (NSDictionary *note in _melody) {
        if (((NSNumber *) note[@"notes"][0]).integerValue != NOTE_TYPE_REST) ++result;
    }
    
    return result;
}

@end
