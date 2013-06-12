//
//  ModalView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ModalView.h"

@implementation ModalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    return self;
}

- (id)initModal
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:CGRectMake(0, screen.size.height - 355, screen.size.width, 355)];

    if (self) {
        self.backgroundColor = [UIColor beige];        
    }
    return self;
}

- (void)confirm:(id)sender
{
    [self.delegate modalView:self isConfirmed:YES];
}

- (void)cancel:(id)sender
{
    [self.delegate modalView:self isConfirmed:NO];
}

@end
