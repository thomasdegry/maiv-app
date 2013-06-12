//
//  GameStepMainView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepMainView.h"

@implementation GameStepMainView

@synthesize header = _header;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        self.header = [[GameStepHeaderView alloc] initWithTitle:@"self.header.lblTitle.text"];
        [self.header.btnInfo addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.header];
    }
    return self;
}

- (void)showInfo:(id)sender
{
    
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
