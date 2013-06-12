//
//  InfoStep4View.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoStep4View.h"

@implementation InfoStep4View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title.text = @"GET YOUR FREE BURGER";
        self.title.textColor = [UIColor blue];
        self.title.frame = CGRectMake(0, 20, 320, 50);
        self.title.textAlignment = NSTextAlignmentCenter;

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
