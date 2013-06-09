//
//  GameButton.m
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameButton.h"

@implementation GameButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bg = [UIImage imageNamed:@"tabbar_circle.png"];
        [self setBackgroundImage:bg  forState:UIControlStateNormal];
        
        UIImage *bg_active = [UIImage imageNamed:@"tabbar_circle_active.png"];
        [self setBackgroundImage:bg_active forState:UIControlStateHighlighted];
        
        UIImage *burger = [UIImage imageNamed:@"tabbar_burger.png"];
        UIImageView *burgerIV = [[UIImageView alloc] initWithImage:burger];
        burgerIV.frame = CGRectMake(35, 14, burger.size.width, burger.size.height);
        [self addSubview:burgerIV];
        
        UILabel *label = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 25, frame.size.width, frame.size.height) andSize:FontAlternateSizeTiny andColor:[UIColor beige]];
        label.text = [@"Create" uppercaseString];
        [self addSubview:label];
        
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
