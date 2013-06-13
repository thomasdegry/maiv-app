//
//  UILabel+MrBurger.h
//  mrburger
//
//  Created by Pieter Beulque on 8/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    FontAlternateSizeTiny = 14,
    FontAlternateSizeSmall = 19,
    FontAlternateSizeMedium = 23,
    FontAlternateSizeBig = 30,
    FontAlternateSizeGiant = 37
} FontAlternateSize;

typedef enum
{
    FontMissionSizeTiny = 25,
    FontMissionSizeSmall = 30,
    FontMissionSizeMedium = 37,
    FontMissionSizeBig = 44
} FontMissionSize;

typedef enum
{
    FontTravelerSizeSmall = 12,
    FontTravelerSizeMedium = 16,
    FontTravelerSizeBig = 40
} FontTravelerSize;

@interface UILabel (MrBurger)

- (id)initWithFontAlternateAndFrame:(CGRect)frame andSize:(FontAlternateSize)size andColor:(UIColor *)color;
- (id)initWithFontMissionAndFrame:(CGRect)frame andSize:(FontMissionSize)size andColor:(UIColor *)color;
- (id)initWithFontTravelerAndFrame:(CGRect)frame andSize:(FontTravelerSize)size andColor:(UIColor *)color;
- (id)initParagraphWithFontTravelerAndFrame:(CGRect)frame andSize:(FontTravelerSize)size andColor:(UIColor *)color andText:(NSString *)text;

- (void)makeParagraph;

@end
