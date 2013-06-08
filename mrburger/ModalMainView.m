//
//  ModalMainView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ModalMainView.h"

@implementation ModalMainView

@synthesize btnModal = _btnModal;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.btnModal = [[RoundedButton alloc] initWithText:@"Open Modal" andX:20 andY:20];
        [self addSubview:self.btnModal];
    }
    return self;
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
