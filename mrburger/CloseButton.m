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
        // Initialization code
        UIImage *closeIcon = [UIImage imageNamed:@"btn_close.png"];
        UIImageView *closeIconIV = [[UIImageView alloc] initWithImage:closeIcon];
        [self addSubview:closeIconIV];
        
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)click:(id)sender
{
    if ( [self.delegate respondsToSelector:@selector(closeButtonClicked:)] ) {
        [self.delegate closeButtonClicked:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
