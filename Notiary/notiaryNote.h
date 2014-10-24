//
//  notiaryNote.h
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface notiaryNote : NSObject

@property (strong, nonatomic) UIImage *noteImage;
@property (strong, nonatomic) NSString *noteTitle;
@property (strong, nonatomic) NSString *noteBody;

- (instancetype) initWithTitle:(NSString *) title withBody:(NSString *) body withImage: (UIImage *) image;

@end
