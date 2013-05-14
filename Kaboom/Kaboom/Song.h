//
//  Song.h
//  Kaboom
//
//  Created by Acsa Lu on 4/22/13.
//
//

#import <Foundation/Foundation.h>
#import "Const.h"


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
+ (Song *) songSonata;
+ (Song *) songStar;
+ (NSString *)noteLengthString:(NoteLength)length;
+ (NSString *)noteTypeString:(NoteType)type;



- (float)lengthInFloat:(NoteLength)length;
- (int)totalBeatableNotes;

@end
