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
    FontAlternateSizeTiny = 17,
    FontAlternateSizeSmall = 19,
    FontAlternateSizeMedium = 23,
    FontAlternateSizeBig = 30
} FontAlternateSize;

@interface UILabel (MrBurger)

- (id)initAWithFontAlternateAndFrame:(CGRect)frame andSize:(FontAlternateSize)size andColor:(UIColor *)color;

@end
