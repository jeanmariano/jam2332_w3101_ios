//
//  AddNewNoteViewController.m
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "AddNewNoteViewController.h"
#import "notiaryNoteDataStore.h"
#import <QuartzCore/QuartzCore.h>

@interface AddNewNoteViewController () <UIImagePickerControllerDelegate, UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteBodyTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) notiaryNoteDataStore *dataStore;

- (IBAction)saveNotiaryNote:(id)sender;

- (IBAction)addPicture:(UIBarButtonItem *)sender;

@end

@implementation AddNewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteImageView.image = [UIImage imageNamed:@"placeholder.png"];
    [self.noteImageView setClipsToBounds:YES];
    self.dataStore = [notiaryNoteDataStore sharedNotiaryNotesDataStore];

    self.noteBodyTextView.delegate = self;
    self.noteBodyTextView.text = @"Add body";
    self.noteBodyTextView.textColor = [UIColor lightGrayColor];
    
    //To make the border look very close to a UITextField
    [self.noteBodyTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
    [self.noteBodyTextView.layer setBorderWidth:1.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.noteBodyTextView.layer.cornerRadius = 5;
    self.noteBodyTextView.clipsToBounds = YES;
    
    [self registerForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveNotiaryNote:(id)sender {
    
    UIImage *noteImage  = self.noteImageView.image;
    NSString *title = self.noteTitleTextField.text;
    NSString *body = self.noteBodyTextView.text;
    
    [self.dataStore createNotiaryNoteWithTitle:title withBody:body withImage:noteImage];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)addPicture:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *notiaryImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.noteImageView.image = notiaryImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    UIImage *notiaryImage = [UIImage imageNamed:@"placeholder.png"];
    self.noteImageView.image = notiaryImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {

    //UIScrollView *scrollView = self.view.view;

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
       // UIScrollView *scrollView = self.view;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Add body"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Add body";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
