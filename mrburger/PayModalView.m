//
//  PayModalView.m
//  mrburger
//
//  Created by Thomas Degry on 18/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "PayModalView.h"

@implementation PayModalView

@synthesize cancel = _cancel;

- (id)initModal
{
    self = [super initModal];
    if (self) {
        // Initialization code
        [self.confirmBtn setTitle:[@"I want to buy a hamburger" uppercaseString] forState:UIControlStateNormal];
        [self.title setText:@"Ohooow"];
        [self.message setText:[@"You already had your free burger for this festival. The next one is on you.." uppercaseString]];
        [self.message makeParagraph];
        self.message.textAlignment = NSTextAlignmentCenter;
        
        self.cancel = [[RoundedButtonAlternate alloc] initWithText:@"Cancel" andX:23 andY:super.frame.size.height - 90];
        
        self.confirmBtn.frame = CGRectMake(self.confirmBtn.frame.origin.x, (self.cancel.frame.origin.y - self.confirmBtn.frame.size.height - 5), self.confirmBtn.frame.size.width, self.confirmBtn.frame.size.height);
        
        [self addSubview:self.cancel];
    }
 
    return self;
}

@end
