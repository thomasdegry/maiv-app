//
//  GameStep2MainView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2MainView.h"

@implementation GameStep2MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.header.lblTitle.text = [@"Step 2 of 3" uppercaseString];
    }
    return self;
}

@end
