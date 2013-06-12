//
//  FacebookButton.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "FacebookButton.h"

@implementation FacebookButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *normalState = [UIImage imageNamed:@"btn_fb_normal"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];
        
        UIImage *activeState = [UIImage imageNamed:@"btn_fb_active"];
        [self setBackgroundImage:activeState forState:UIControlStateHighlighted];
    }
    return self;
}

@end
