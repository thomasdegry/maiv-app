//
//  GameStep2InviteView.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2InviteView.h"
#import "IphoneLoop.h"

@implementation GameStep2InviteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initModal
{
    self = [super initModal];
    if (self) {            
        self.title.text = @"Someone wants you!";
       
        
        UILabel *paragraph = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(130, 75, 160, 120) andSize:FontAlternateSizeSmall andColor:[UIColor blueDarkened]];
        paragraph.text = [@"Build a burger with your iPhones! Put your iPhone underneath the other to accept the invitation!" uppercaseString];
        [paragraph makeParagraph];
        [self addSubview:paragraph];
        
        IphoneLoop *iphoneLoopAnimation = [[IphoneLoop alloc] initWithFrame:CGRectMake(-15, -50, 160, 259)];
        [self addSubview:iphoneLoopAnimation];

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
