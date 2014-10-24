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

@property (strong, nonatomic) notiaryNoteDataStore *dataStore;

- (IBAction)saveNotiaryNote:(id)sender;

- (IBAction)takeNotePicture:(UIBarButtonItem *)sender;

@end

@implementation AddNewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteImageView.image = [UIImage imageNamed:@"image1.jpg"];
    
    self.dataStore = [notiaryNoteDataStore sharedNotiaryNotesDataStore];
    
    //To make the border look very close to a UITextField
    [self.noteBodyTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
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
    
    UIImage *noteImage  = self.noteImageView.image;
    NSString *title = self.noteTitleTextField.text;
    NSString *body = self.noteBodyTextView.text;
    
    [self.dataStore createNotiaryNoteWithTitle:title withBody:body withImage:noteImage];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takeNotePicture:(UIBarButtonItem *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    UIImage *notiaryImage = [UIImage imageNamed:@"image1.jpg"];
    self.noteImageView.image = notiaryImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
