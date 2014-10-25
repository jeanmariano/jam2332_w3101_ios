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


@interface NoteViewController()

@property (weak, nonatomic) IBOutlet UINavigationItem *noteTitle;
@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UITextView *noteBody;
@property (weak, nonatomic) IBOutlet UILabel *noteTime;

- (IBAction)deleteNote:(id)sender;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteTitle.title = self.currentNote.noteTitle;
    self.noteBody.text = self.currentNote.noteBody;
    self.noteImage.image = self.currentNote.noteImage;
    self.noteTime.text = self.currentNote.noteTime;
    [self.noteImage setClipsToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    self.noteTitle.title = self.currentNote.noteTitle;
    self.noteBody.text = self.currentNote.noteBody;
    self.noteImage.image = self.currentNote.noteImage;
    self.noteTime.text = self.currentNote.noteTime;
    [self.noteImage setClipsToBounds:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:(@"editNote") ])
    {
        NoteViewController *editNote = segue.destinationViewController;
        
        editNote.indexPath = self.indexPath;
        editNote.currentNote = self.currentNote;
    }
}


- (IBAction)deleteNote:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to delete this note?"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.dataStore.notiaryNoteArray removeObjectAtIndex:_indexPath.row];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
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
