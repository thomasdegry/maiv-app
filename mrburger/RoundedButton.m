//
//  RoundedButton.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton
@synthesize label = _label;
@synthesize string = _string;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *normalState = [UIImage imageNamed:@"btn_orange_normal.png"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"AlternateGothicCom-No2" size:23];
        self.titleLabel.textColor = [UIColor whiteColor];

        UIImage *activeState = [UIImage imageNamed:@"btn_orange_activeNr2.png"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
    }
    return self;
}

- (id)initWithText:(NSString *)text andX:(float)x andY:(float)y
{
    self = [self initWithFrame:CGRectMake(x, y, 274, 48)];
    
    if (self) {
        [self setTitle:[text uppercaseString] forState:UIControlStateNormal];
    }
    
    return self;
}

@end
