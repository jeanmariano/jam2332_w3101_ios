//
//  NoteTableViewCell.h
//  Notiary
//
//  Created by Jean Mariano on 10/19/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface NoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteSnippetLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteTimeLabel;



@end
