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
        NSLog(@"Invite - Init Modal");
        
        self.title.text = @"Connecting!";
        
        Loader *loader = [[Loader alloc] initWithFrame:CGRectMake(135, 75, 50, 50)];
        [self addSubview:loader];
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
