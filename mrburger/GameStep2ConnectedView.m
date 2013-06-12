//
//  GameStep2ConnectedView.m
//  mrburger
//
//  Created by Pieter Beulque on 10/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2ConnectedView.h"

@implementation GameStep2ConnectedView

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
        self.title.text = @"Put me back!";
        
        UILabel *paragraph = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(130, 75, 160, 120) andSize:FontAlternateSizeSmall andColor:[UIColor blueDarkened]];
        paragraph.text = [@"If you could keep your iPhones together until you made your burger, that would be awesome" uppercaseString];
        [paragraph makeParagraph];
        [self addSubview:paragraph];
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
