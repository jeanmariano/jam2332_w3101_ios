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


#pragma mark - MFMailCompose delegate methods

- (IBAction)emailNote:(id)sender {
    NSLog(@"%@", sender);
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        
        NSString *messageSubject = self.noteTitle.title;
        NSString *messageBody = self.noteBody.text;
        
        NSData *imageData = UIImageJPEGRepresentation(self.noteImage.image, 1);
        [mailViewController addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"NoteAttachment.jpg"];
        
        [mailViewController setSubject:messageSubject];
        [mailViewController setMessageBody:messageBody isHTML:NO];
        
        [self.navigationController presentViewController:mailViewController animated:YES completion:nil];
        
    }
    else {
        
        NSLog(@"Device is unable to send email in its current state.");
        
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
