//
//  GameStep2ConnectingView.m
//  mrburger
//
//  Created by Pieter Beulque on 10/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2ConnectingView.h"

@implementation GameStep2ConnectingView

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
        self.title.text = @"Connecting!";
        
        Loader *loader = [[Loader alloc] initWithFrame:CGRectMake(135, 115, 50, 50)];
        [self addSubview:loader];
        
        self.confirmBtn.hidden = YES;
        
        self.declineBtn = [[RoundedButtonAlternate alloc] initWithText:@"Decline" andX:23 andY:(self.frame.size.height - 87)];
        [self addSubview:self.declineBtn];
        [self.declineBtn setTitle:@"CANCEL CONNECTION" forState:UIControlStateNormal];
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
