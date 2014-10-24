//
//  NoteViewController.m
//  Notiary
//
//  Created by Jean Mariano on 10/23/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "NoteViewController.h"
#import "notiaryNoteDataStore.h"
#import "notiaryNote.h"

@interface NoteViewController ()

@property (strong, nonatomic) notiaryNoteDataStore *dataStore;

@property (weak, nonatomic) IBOutlet UINavigationItem *noteTitle;
@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UITextView *noteBody;

- (IBAction)deleteNote:(id)sender;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteTitle.title = self.currentNote.noteTitle;
    self.noteBody.text = self.currentNote.noteBody;
    self.noteImage.image = self.currentNote.noteImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    self.noteTitle.title = self.currentNote.noteTitle;
    self.noteBody.text = self.currentNote.noteBody;
    self.noteImage.image = self.currentNote.noteImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:(@"editNote") ])
    {
        NoteViewController *editNote = segue.destinationViewController;
        
        editNote.currentNote = self.currentNote;
    }
}


- (IBAction)deleteNote:(id)sender {
    [self.dataStore delete:self.currentNote];
}
@end
