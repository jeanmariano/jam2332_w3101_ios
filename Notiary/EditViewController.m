//
//  EditViewController.m
//  Notiary
//
//  Created by Jean Mariano on 10/24/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "EditViewController.h"
#import "notiaryNoteDataStore.h"
#import <QuartzCore/QuartzCore.h>

@interface EditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (weak, nonatomic) IBOutlet UITextView *noteBodyTextView;

- (IBAction)editPicture:(id)sender;

- (IBAction)saveNotiaryNote:(id)sender;

@property (strong, nonatomic) notiaryNoteDataStore *dataStore;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteTitleTextField.text = self.currentNote.noteTitle;
    self.noteBodyTextView.text = self.currentNote.noteBody;
    self.noteImageView.image = self.currentNote.noteImage;
    
    //To make the border look very close to a UITextField
    [self.noteBodyTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
    [self.noteBodyTextView.layer setBorderWidth:1.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.noteBodyTextView.layer.cornerRadius = 5;
    self.noteBodyTextView.clipsToBounds = YES;
    // Do any additional setup after loading the view.
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
    
    self.currentNote.noteTitle = self.noteTitleTextField.text;
    self.currentNote.noteBody = self.noteBodyTextView.text;
    self.currentNote.noteImage = self.noteImageView.image;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editPicture:(UIBarButtonItem *)sender {
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
    
    UIImage *notiaryImage = [UIImage imageNamed:@"image1.jpg"];
    self.noteImageView.image = notiaryImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
