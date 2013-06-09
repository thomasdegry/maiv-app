//
//  GameStep1MainView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep1MainView.h"

@implementation GameStep1MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.header.lblTitle.text = [@"Step 1 of 3" uppercaseString];
        
        self.btnStart = [[RoundedButton alloc] initWithText:@"Get Started!" andX:20 andY:390];
        [self addSubview:self.btnStart];
        
        UILabel *lblHello = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 60, 320, 55) andSize:FontAlternateSizeBig andColor:[UIColor orange]];
        lblHello.text = [@"Hello there" uppercaseString];
        [self addSubview:lblHello];
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
