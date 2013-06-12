//
//  UILabel+MrBurger.m
//  mrburger
//
//  Created by Pieter Beulque on 8/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "UILabel+MrBurger.h"

@implementation UILabel (MrBurger)

- (id)initWithFontAlternateAndFrame:(CGRect)frame andSize:(FontAlternateSize)size andColor:(UIColor *)color
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

- (id)initWithFontMissionAndFrame:(CGRect)frame andSize:(FontMissionSize)size andColor:(UIColor *)color
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

- (id)initWithFontTravelerAndFrame:(CGRect)frame andSize:(FontTravelerSize)size andColor:(UIColor *)color
{
    self = [self initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont fontWithName:@"Traveler-Medium" size:size];
        self.textColor = color;
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (id)initParagraphWithFontTravelerAndFrame:(CGRect)frame andSize:(FontTravelerSize)size andColor:(UIColor *)color andText:(NSString *)text
{
    self = [self initWithFrame:frame];
    
    if (self) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.minimumLineHeight = 22.f;
        paragraphStyle.maximumLineHeight = 22.f;
        
        UIFont *font = [UIFont fontWithName:@"Traveler-Medium" size:FontTravelerSizeMedium];
        NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragraphStyle,};
        
        self.font = font;
        self.backgroundColor = [UIColor clearColor];
        self.attributedText = [[NSAttributedString alloc] initWithString:text  attributes:attributtes];
    }
    
    return self;
}

- (void)makeParagraph
{
    self.adjustsFontSizeToFitWidth = NO;
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentLeft;
}

@end
