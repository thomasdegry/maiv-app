//
//  UnavailableCell.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "UnavailableCell.h"

@implementation UnavailableCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.text = @"There's noone around";
        self.detailTextLabel.text = @"No burger on your own!";
        self.imageView.image = [UIImage imageNamed:@"sad_face"];
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
