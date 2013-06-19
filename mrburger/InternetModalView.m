//
//  InternetModalView.m
//  mrburger
//
//  Created by Pieter Beulque on 19/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InternetModalView.h"

@implementation InternetModalView

- (id) initModal
{
    self = [super initModal];
    
    if (self) {
        CGRect frame = self.confirmBtn.frame;
        
        [self.confirmBtn removeFromSuperview];
        self.confirmBtn = nil;

        [self.title setText:@"We're sorry"];
        [self.message setText:[@"You don't seem to be connected to the internet. Please turn on your 3G or connect to our hotspot!" uppercaseString]];
        [self.message makeParagraph];
        self.message.textAlignment = NSTextAlignmentCenter;
        
        self.cancelBtn = [[RoundedButtonAlternate alloc] initWithText:@"I'll turn it on" andX:frame.origin.x andY:frame.origin.y];
                
        [self addSubview:self.cancelBtn];
    }
    
    return self;
}

@end
