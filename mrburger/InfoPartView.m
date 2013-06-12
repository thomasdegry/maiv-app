//
//  InfoPartView.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoPartView.h"

@implementation InfoPartView

@synthesize title = _title;
@synthesize description = _description;
@synthesize icon = _icon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(0, 20, 320, 50) andSize:FontAlternateSizeBig andColor:[UIColor blue]];

        [self addSubview:self.title];
    }
    return self;
}

- (void)animateIn
{
    
}

- (void)animateOut
{
    
}

@end
