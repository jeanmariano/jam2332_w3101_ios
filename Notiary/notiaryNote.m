//
//  notiaryNote.m
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "notiaryNote.h"

@implementation notiaryNote

- (instancetype)init
{
    return [self initWithTitle:@"" withBody:@"" withImage:NULL];
}

- (instancetype)initWithTitle:(NSString *)title withBody:(NSString *)body withImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _noteTitle = title;
        _noteBody = body;
        _noteImage = image;

        //NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *resultString = [dateFormatter stringFromDate: currentTime];
        _noteTime = resultString;
        NSLog(resultString);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.noteTitle = [decoder decodeObjectForKey:@"noteTitle"];
    self.noteBody = [decoder decodeObjectForKey:@"noteBody"];
    self.noteImage = [decoder decodeObjectForKey:@"noteimage"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.noteTitle forKey:@"noteTitle"];
    [encoder encodeObject:self.noteBody forKey:@"noteBody"];
    [encoder encodeInteger:self.noteImage forKey:@"noteImage"];
}


@end
