//
//  InfoButton.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoButton.h"

@implementation InfoButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *infoIcon = [UIImage imageNamed:@"btn_info.png"];
        UIImageView *infoIconIV = [[UIImageView alloc] initWithImage:infoIcon];
        [self addSubview:infoIconIV];
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
