//
//  UIColor+MrBurger.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "UIColor+MrBurger.h"

@implementation UIColor (MrBurger)

+ (UIColor *) orange {
    return [UIColor colorWithRed:0.99f green:0.41f blue:0.14f alpha:1.00f];;
}

+ (UIColor *) orangeDarkened {
    return [UIColor colorWithRed:0.94f green:0.30f blue:0.05f alpha:1.00f];
}

+ (UIColor *) blue {
    return [UIColor colorWithRed:0.18f green:0.21f blue:0.23f alpha:1.00f];
}

+ (UIColor *) blueDarkened {
    return [UIColor colorWithRed:0.12f green:0.14f blue:0.16f alpha:1.00f];
}

+ (UIColor *) blueLightened {
    return [UIColor colorWithRed:0.24f green:0.27f blue:0.29f alpha:1.00f];
}

+ (UIColor *) white {
    return [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
}

@end
