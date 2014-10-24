//
//  notiaryNoteDataStore.h
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface notiaryNoteDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *notiaryNoteArray;

+ (instancetype) sharedNotiaryNotesDataStore;

- (void) createNotiaryNoteWithTitle:(NSString *)title withBody:(NSString *)body withImage:(UIImage *) image;


@end
