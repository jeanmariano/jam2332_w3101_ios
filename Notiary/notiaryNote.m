//
//  notiaryNote.m
//  Notiary
//
//  Created by Jean Mariano on 10/20/14.
//  Copyright (c) 2014 JMariano. All rights reserved.
//

#import "notiaryNote.h"

@implementation notiaryNote

- (instancetype)init
{
    return [self initWithTitle:@"" withBody:@"" withImage:NULL];
}

- (instancetype)initWithTitle:(NSString *)title withBody:(NSString *)body withImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _noteTitle = title;
        _noteBody = body;
        _noteImage = image;
    }
    return self;
}

@end
