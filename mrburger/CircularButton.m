//
//  CircularButton.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "CircularButton.h"

@implementation CircularButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *normalState = [UIImage imageNamed:@"btn_circle_normal"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];
        
        UIImage *activeState = [UIImage imageNamed:@"btn_circle_active.png"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
    }
    return self;
}

- (id)initWithX:(float)x andY:(float)y
{
    return [self initWithFrame:CGRectMake(x, y, 29, 29)];
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
