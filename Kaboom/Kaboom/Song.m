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
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 9
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 13
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 17
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 22
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    @{@"length":@(NOTE_LENGTH_8TH), @"notes":@[@(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT)]},
                    
                    
                    // 26
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
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
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
  @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
  @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
  @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
  @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_LEFT), @(NOTE_TYPE_RIGHT)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    ];
    
    song.interval = 0.452;
    return song;
}

#pragma mark - Song Sonata

+ (Song *)songSonata
{
    Song *song = [[Song alloc] init];
    song.melody = @[
  
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_ALL), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 5
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 10
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 15
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_2ND), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 20
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]},
                    
                    // 25
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    // 30
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    
                    // 33
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_FIRE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_REST)]}
                    
                    ];
    song.interval = 0.4;
    return song;
}

#pragma mark - Song Little Star

+ (Song *)songStar
{
    Song *song = [[Song alloc] init];
    song.melody = @[
                    // 1
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_IN1)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_2ND),@"notes":@[@(NOTE_TYPE_REST)]},

                    // 5
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_IN3)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB), @(NOTE_TYPE_IN3)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_FA)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_DE)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_BC)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_FA)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_DE)]},

                    // 10
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_BC)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_FA)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) ]},
                    @{@"length":@(NOTE_LENGTH_2ND),@"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH),@"notes":@[@(NOTE_TYPE_REST)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_IN3)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA),  @(NOTE_TYPE_IN3)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB), @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_AB)]},

                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_EF)]},

                    // 15
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_CD)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_AB)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_EF)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE) , @(NOTE_TYPE_P_CD)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF) , @(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA) , @(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB) , @(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC) , @(NOTE_TYPE_P_AB)]},
                                                             
                    // 20
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD) , @(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_2ND),@"notes":@[@(NOTE_TYPE_REST)]},
                    @{@"length":@(NOTE_LENGTH_4TH),@"notes":@[@(NOTE_TYPE_REST)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_IN3)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_AB)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_BC)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_CD)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_DE)]},
                                                             
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_EF)]},
                    @{@"length":@(NOTE_LENGTH_4TH), @"notes":@[@(NOTE_TYPE_P_FA)]},
                    @{@"length":@(NOTE_LENGTH_2ND),@"notes":@[@(NOTE_TYPE_REST)]},
                ];
                                                               song.interval = 0.5f;
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
        case NOTE_TYPE_BOUNCE_LR1: return @"bounce L2R1";
        case NOTE_TYPE_BOUNCE_LR2: return @"bounce L2R2";
        case NOTE_TYPE_BOUNCE_RL1: return @"bounce R2L1";
        case NOTE_TYPE_BOUNCE_RL2: return @"bounce R2L2";
            
        case NOTE_TYPE_IN0 : return @"IN0";
        case NOTE_TYPE_IN1 : return @"IN1";
        case NOTE_TYPE_IN2 : return @"IN2";
        case NOTE_TYPE_IN3 : return @"IN3";
            
        case NOTE_TYPE_P_AB: return @"P_AB";
        case NOTE_TYPE_P_BC: return @"P_BC";
        case NOTE_TYPE_P_CD: return @"P_CD";
        case NOTE_TYPE_P_DE: return @"P_DE";
        case NOTE_TYPE_P_EF: return @"P_EF";
        case NOTE_TYPE_P_FA: return @"P_FA";
        
        case NOTE_TYPE_P_AF: return @"P_AF";
        case NOTE_TYPE_P_FE: return @"P_FE";
        case NOTE_TYPE_P_ED: return @"P_ED";
        case NOTE_TYPE_P_DC: return @"P_DC";
        case NOTE_TYPE_P_CB: return @"P_CB";
        case NOTE_TYPE_P_BA: return @"P_BA";
        
        default: return @"";
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
