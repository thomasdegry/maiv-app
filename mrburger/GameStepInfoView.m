//
//  GameStepInfoView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepInfoView.h"

@implementation GameStepInfoView

@synthesize title = _title;
@synthesize message = _message;
@synthesize confirmBtn = _confirmBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
            self.title = [[UILabel alloc] initAWithFontMissionAndFrame:CGRectMake(0, 20, 320, 50) andSize:FontMissionSizeMedium andColor:[UIColor orange]];
            self.message = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(60, 40, 200, 200) andSize:FontAlternateSizeMedium andColor:[UIColor blueDarkened]];
   
        
            self.confirmBtn = [[RoundedButton alloc] initWithText:@"I get it" andX:23 andY:(frame.size.height - 87)];
        
            [self addSubview:self.title];
            [self addSubview:self.message];
            [self addSubview:self.confirmBtn];
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
