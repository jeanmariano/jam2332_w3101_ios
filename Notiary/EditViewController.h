//
//  EditViewController.h
//  Notiary
//
//  Created by Jean Mariano on 10/24/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notiaryNote.h"

@interface EditViewController : UIViewController

@property (strong, nonatomic) notiaryNote *currentNote;
@property NSIndexPath *indexPath;

@end
