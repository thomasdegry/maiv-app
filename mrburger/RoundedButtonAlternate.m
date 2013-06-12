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
        UIImage *normalState = [UIImage imageNamed:@"btn_blue_normal"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];

        UIImage *activeState = [UIImage imageNamed:@"btn_blue_active"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
    }
    return self;
}

@end
