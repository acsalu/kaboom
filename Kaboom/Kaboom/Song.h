//
//  Song.h
//  Kaboom
//
//  Created by Acsa Lu on 4/22/13.
//
//

#import <Foundation/Foundation.h>

enum NoteType {
    NOTE_TYPE_REST = 0, 
    NOTE_TYPE_LEFT, NOTE_TYPE_RIGHT,
    NOTE_TYPE_BOUNCE_LR1, NOTE_TYPE_BOUNCE_LR2,
    NOTE_TYPE_BOUNCE_RL1, NOTE_TYPE_BOUNCE_RL2,
    NOTE_TYPE_CLAP
};

enum NoteLength {
    NOTE_LENGTH_16TH = 0,
    NOTE_LENGTH_8TH, NOTE_LENGTH_4TH, NOTE_LENGTH_2ND, NOTE_LENGTH_ALL
};

typedef enum NoteType NoteType;
typedef enum NoteLength NoteLength;

@interface Note : NSObject

@property (nonatomic) NoteType type;
@property (nonatomic) NoteLength length;

+ (Note *) noteWithType:(NoteType)type andLength:(NoteLength)length;

@end

@interface Song : NSObject

@property (nonatomic) int currentIdx;
@property (nonatomic) float interval;
@property (nonatomic, strong) NSArray *melody;

+ (Song *) newSong;
+ (NSString *)noteLengthString:(NoteLength)length;
+ (NSString *)noteTypeString:(NoteType)type;

- (float)lengthInFloat:(NoteLength)length;
- (int)totalBeatableNotes;

@end
