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
        UIImage *bg = [UIImage imageNamed:@"tabbar_circle.png"];
        [self setBackgroundImage:bg  forState:UIControlStateNormal];
        
        UIImage *bgActive = [UIImage imageNamed:@"tabbar_circle_active.png"];
        [self setBackgroundImage:bgActive forState:UIControlStateHighlighted];
        
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

@end
