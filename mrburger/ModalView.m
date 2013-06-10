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
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initModal
{
    NSLog(@"Modal - Init Modal");
    CGRect screen = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:CGRectMake(0, screen.size.height - 355, screen.size.width, 355)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.87f alpha:1.00f];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
