//
//  UILabel+MrBurger.m
//  mrburger
//
//  Created by Pieter Beulque on 8/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "UILabel+MrBurger.h"

@implementation UILabel (MrBurger)

- (id)initAWithFontAlternateAndFrame:(CGRect)frame andSize:(FontAlternateSize)size andColor:(UIColor *)color
{
    self = [self initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont fontWithName:@"AlternateGothicCom-No2" size:size];
        self.textColor = color;
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (id)initAWithFontMissionAndFrame:(CGRect)frame andSize:(FontAlternateSize)size andColor:(UIColor *)color
{
    self = [self initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont fontWithName:@"Mission-Script" size:size];
        self.textColor = color;
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

@end
