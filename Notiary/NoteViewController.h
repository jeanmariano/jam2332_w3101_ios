//
//  NoteViewController.h
//  Notiary
//
//  Created by Jean Mariano on 10/23/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>
#import "notiaryNote.h"
#import "notiaryNoteDataStore.h"

@interface NoteViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) notiaryNote *currentNote;
@property (strong, nonatomic) notiaryNoteDataStore *dataStore;
@property NSIndexPath *indexPath;


@end
