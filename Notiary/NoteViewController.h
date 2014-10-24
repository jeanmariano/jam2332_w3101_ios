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

@interface NoteViewController : UIViewController

@property (strong, nonatomic) notiaryNote *currentNote;

@end
