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
        // Initialization code
        UIImage *normalState = [UIImage imageNamed:@"btn_fb_normal"];
        [self setBackgroundImage:normalState  forState:UIControlStateNormal];
        
        UIImage *activeState = [UIImage imageNamed:@"btn_fb_active"];
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
