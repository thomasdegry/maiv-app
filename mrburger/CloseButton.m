//
//  CloseButton.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "CloseButton.h"

@implementation CloseButton

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *closeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_close.png"]];
        [self addSubview:closeIcon];
        
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)click:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(closeButtonClicked:)]) {
        [self.delegate closeButtonClicked:self];
    }
}

@end
