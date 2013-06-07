//
//  RoundedButtonAlternate.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RoundedButtonAlternate.h"

@implementation RoundedButtonAlternate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel.textColor = [UIColor blueColor];

        UIImage *normalState = [UIImage imageNamed:@"btn_blue_normal"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];

        UIImage *activeState = [UIImage imageNamed:@"btn_blue_active"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
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
