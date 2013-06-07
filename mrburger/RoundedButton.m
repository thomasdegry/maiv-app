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
        // Initialization code
        UIImage *normalState = [UIImage imageNamed:@"btn_orange_normal.png"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];
        [self setTitle:[self.string uppercaseString] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"AlternateGothicCom-No2" size:23];
        self.titleLabel.textColor = [UIColor whiteColor];

        UIImage *activeState = [UIImage imageNamed:@"btn_orange_activeNr2.png"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
    }
    return self;
}

- (id)initWithText:(NSString *)text {
    self.string = text;
    return [self initWithFrame:CGRectMake(0, 0, 274, 48)];
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
