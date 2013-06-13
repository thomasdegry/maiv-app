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
        [self addSubview:self.header];
    }
    return self;
}

@end
