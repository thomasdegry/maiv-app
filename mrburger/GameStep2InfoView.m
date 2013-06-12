//
//  GameStep2InfoView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2InfoView.h"

@implementation GameStep2InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initModal
{
    self = [super initModal];
    if (self) {
        self.title.text = @"Great choice!";
        self.message.text = @"NOW GO FIND SOME OTHER INGREDIENTS NEARBY OUR FESTIVAL TRUCK. JUST TALK TO SOME PEOPLE. I KNOW YOU CAN DO IT!";
        [self.message makeParagraph];
        self.message.textAlignment = NSTextAlignmentCenter;
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
