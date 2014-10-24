//
//  notiaryNoteDataStore.m
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "notiaryNoteDataStore.h"
#import "notiaryNote.h"

@implementation notiaryNoteDataStore

+ (instancetype)sharedNotiaryNotesDataStore {
    static notiaryNoteDataStore *_sharedNotiaryNotesDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNotiaryNotesDataStore = [[notiaryNoteDataStore alloc] init];
    });
    
    return _sharedNotiaryNotesDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _notiaryNoteArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createNotiaryNoteWithTitle:(NSString *)title withBody:(NSString *)body withImage:(UIImage *)image
{
    notiaryNote *newNote = [[notiaryNote alloc] initWithTitle:title withBody:body withImage:image];
    
    [self.notiaryNoteArray addObject:newNote];
}

@end
