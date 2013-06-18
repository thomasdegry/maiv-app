//
//  PayModalView.m
//  mrburger
//
//  Created by Thomas Degry on 18/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "PayModalView.h"

@implementation PayModalView

- (id)initModal
{
    self = [super initModal];
    if (self) {
        // Initialization code
        [self.confirmBtn setTitle:[@"I want to buy a hamburger" uppercaseString] forState:UIControlStateNormal];
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
